#!/bin/bash
set -e

echo "=== Iniciando Projeto ISP ==="


# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para log colorido
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar se está executando como root
if [[ $EUID -eq 0 ]]; then
   log_error "Este script não deve ser executado como root"
   exit 1
fi

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    log_warn "Docker não encontrado. Instalando..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    log_info "Docker instalado. Você pode precisar fazer logout/login para usar sem sudo"
fi

# Verificar se Docker Compose está instalado
if ! command -v docker-compose &> /dev/null && ! command -v /usr/local/bin/docker-compose &> /dev/null; then
    log_warn "Docker Compose não encontrado. Instalando..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    log_info "Docker Compose instalado"
fi

# Definir comando do docker-compose
if command -v /usr/local/bin/docker-compose &> /dev/null; then
    DOCKER_COMPOSE="/usr/local/bin/docker-compose"
else
    DOCKER_COMPOSE="docker-compose"
fi

# Verificar se systemd-resolved está ativo e parar se necessário
if sudo systemctl is-active --quiet systemd-resolved; then
    log_warn "systemd-resolved está ativo e pode conflitar com a porta 53"
    log_info "Parando systemd-resolved..."
    sudo systemctl stop systemd-resolved
fi

# Verificar se a porta 53 está livre
if sudo netstat -tulpn | grep -q ":53 "; then
    log_error "Porta 53 ainda está em uso. Verifique outros serviços DNS"
    sudo netstat -tulpn | grep ":53 "
    exit 1
fi

# Verificar se estamos no diretório correto
if [[ ! -f "docker-compose.yml" ]]; then
    log_error "Arquivo docker-compose.yml não encontrado no diretório atual"
    log_info "Certifique-se de estar no diretório do projeto ISP"
    exit 1
fi

# Parar containers existentes se estiverem rodando
log_info "Parando containers existentes (se houver)..."
sudo $DOCKER_COMPOSE down 2>/dev/null || true

# Construir imagens
log_info "Construindo imagens Docker..."
sudo $DOCKER_COMPOSE build

if [[ $? -ne 0 ]]; then
    log_error "Falha na construção das imagens"
    exit 1
fi

# Iniciar serviços
log_info "Iniciando serviços..."
sudo $DOCKER_COMPOSE up -d

if [[ $? -ne 0 ]]; then
    log_error "Falha ao iniciar os serviços"
    exit 1
fi

# Aguardar inicialização
log_info "Aguardando inicialização dos serviços..."
sleep 15

# Verificar status dos containers
log_info "Verificando status dos containers..."
sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Verificar se todos os containers estão rodando
EXPECTED_CONTAINERS=("haproxy" "dns" "portal" "postfix" "dovecot" "webmail")
RUNNING_CONTAINERS=$(sudo docker ps --format "{{.Names}}")

for container in "${EXPECTED_CONTAINERS[@]}"; do
    if echo "$RUNNING_CONTAINERS" | grep -q "$container"; then
        log_info "✓ $container está rodando"
    else
        log_error "✗ $container não está rodando"
    fi
done

# Configurar entradas no /etc/hosts se não existirem
log_info "Verificando configuração do /etc/hosts..."
if ! grep -q "portal.asa.br" /etc/hosts; then
    log_info "Adicionando entradas ao /etc/hosts..."
    sudo bash -c 'cat >> /etc/hosts << EOF

# Entradas do Projeto ISP
127.0.0.1 portal.asa.br
127.0.0.1 webmail.asa.br
127.0.0.1 mail.asa.br
EOF'
fi

# Testes básicos de conectividade
log_info "Executando testes básicos..."

# Testar portal HTTP (deve redirecionar para HTTPS)
if curl -s -H "Host: portal.asa.br" http://localhost | grep -q "301"; then
    log_info "Portal HTTP (redirecionamento para HTTPS)"
else
    log_warn "Portal HTTP não está redirecionando corretamente"
fi

# Testar portal HTTPS
if curl -k -s -H "Host: portal.asa.br" https://localhost | grep -q "Portal ISP"; then
    log_info "Portal HTTPS funcionando"
else
    log_warn "Portal HTTPS não está respondendo corretamente"
fi

# Testar webmail
if curl -k -s -H "Host: webmail.asa.br" https://localhost | grep -q "Webmail"; then
    log_info "Webmail funcionando"
else
    log_warn "Webmail não está respondendo corretamente"
fi

# Testar DNS
if command -v dig &> /dev/null; then
    if dig @127.0.0.1 portal.asa.br +short | grep -q "127.0.0.1"; then
        log_info "DNS funcionando"
    else
        log_warn "DNS não está resolvendo corretamente"
    fi
else
    log_warn "comando 'dig' não encontrado, pulando teste de DNS"
fi

echo ""
echo "=== Projeto ISP iniciado com sucesso! ==="
echo ""
echo "Serviços disponíveis:"
echo "   Portal:  https://portal.asa.br"
echo "   Webmail: https://webmail.asa.br"
echo "   DNS:     127.0.0.1:53"
echo ""
echo "Contas de e-mail de teste:"
echo "   admin@asa.br (senha: admin123)"
echo "   user@asa.br  (senha: user123)"
echo "   test@asa.br  (senha: test123)"
echo ""
echo "Comandos úteis:"
echo "   sudo $DOCKER_COMPOSE logs -f     # Ver logs"
echo "   sudo $DOCKER_COMPOSE restart     # Reiniciar"
echo "   sudo $DOCKER_COMPOSE down        # Parar"
echo "   sudo docker ps                   # Status"

log_info "Instalação concluída!"

