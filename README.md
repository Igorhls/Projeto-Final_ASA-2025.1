# Projeto ISP - Servidor de Provedor de Internet

## Visão Geral

Este projeto implementa uma infraestrutura completa de provedor de internet (ISP) utilizando Docker e Docker Compose. A arquitetura inclui:

- **HAProxy**: Proxy reverso e balanceador de carga
- **DNS**: Servidor DNS para resolução de domínios
- **Portal Web**: Interface principal do provedor
- **Sistema de E-mail**: Postfix (SMTP) + Dovecot (IMAP)
- **Webmail**: Interface web Roundcube para acesso aos e-mails
- **SSL/TLS**: Certificados automatizados com Let's Encrypt

## Arquitetura

```
Internet → HAProxy (80/443/25/587/993) → Serviços Internos
                    ↓
    ┌─────────────────────────────────────────┐
    │  Portal (portal.asa.br)                 │
    │  Webmail (webmail.asa.br)              │
    │  E-mail (mail.asa.br)                  │
    │  DNS (asa.br)                          │
    └─────────────────────────────────────────┘
```

## Início Rápido

### Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+
- Ubuntu 22.04+ (recomendado)

### Instalação

1. **Clone ou extraia o projeto:**
   ```bash
   cd ~/isp-project/isp-project
   ```

2. **Instale dependências (se necessário):**
   ```bash
   # Docker
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER

   # Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. **Resolva conflito de porta DNS:**
   ```bash
   sudo systemctl stop systemd-resolved
   ```

4. **Configure hosts locais (para testes):**
   ```bash
   sudo bash -c 'cat >> /etc/hosts << EOF
   127.0.0.1 portal.asa.br
   127.0.0.1 webmail.asa.br
   127.0.0.1 mail.asa.br
   EOF'
   ```

5. **Inicie os serviços:**
   ```bash
   sudo docker-compose build
   sudo docker-compose up -d
   ```

### Verificação

```bash
# Verificar containers
sudo docker ps

# Testar portal
curl -k -H "Host: portal.asa.br" https://localhost

# Testar webmail
curl -k -H "Host: webmail.asa.br" https://localhost

# Testar DNS
dig @127.0.0.1 portal.asa.br
```

## Acesso aos Serviços

- **Portal**: https://portal.asa.br
- **Webmail**: https://webmail.asa.br
- **DNS**: 127.0.0.1:53

### Contas de E-mail de Teste

- `admin@asa.br` / `admin123`
- `user@asa.br` / `user123`
- `test@asa.br` / `test123`

## Estrutura do Projeto

```
isp-project/
├── docker-compose.yml          # Orquestração dos serviços
├── haproxy/                    # Configuração do proxy reverso
│   ├── Dockerfile
│   ├── haproxy.cfg
│   ├── generate_certs.sh       # Script para certificados SSL
│   └── certbot/               # Certificados Let's Encrypt
├── dns/                       # Servidor DNS
│   ├── Dockerfile
│   ├── named.conf.local
│   └── zones/db.asa.br
├── portal/                    # Portal web
│   └── index.html
├── email/                     # Sistema de e-mail
│   ├── postfix/              # Servidor SMTP
│   │   ├── Dockerfile
│   │   ├── main.cf
│   │   └── vmailbox
│   └── dovecot/              # Servidor IMAP
│       ├── Dockerfile
│       ├── dovecot.conf
│       └── users/virtual_users
└── config.inc.php            # Configuração do Roundcube
```

## Comandos Úteis

```bash
# Visualizar logs
sudo docker-compose logs -f

# Reiniciar serviços
sudo docker-compose restart

# Parar todos os serviços
sudo docker-compose down

# Reconstruir imagens
sudo docker-compose build --no-cache

# Verificar uso de recursos
sudo docker stats
```

## Solução de Problemas

### Porta 53 em uso
```bash
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
```

### Certificados SSL
```bash
# Gerar novos certificados
sudo bash haproxy/generate_certs.sh
```

### Logs de erro
```bash
# Verificar logs específicos
sudo docker-compose logs haproxy
sudo docker-compose logs postfix
sudo docker-compose logs dovecot
```

## Segurança

- Altere as senhas padrão antes de usar em produção
- Configure firewall adequado
- Mantenha as imagens Docker atualizadas
- Implemente backup regular dos dados



