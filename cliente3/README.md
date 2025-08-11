# Cliente 3 - Arquitetura Docker

Este projeto implementa a arquitetura do Cliente 3 com containers isolados para:
- Proxy Reverso (Nginx)
- Portal Estático
- CMS WordPress

## Estrutura do Projeto

```
cliente3/
├── docker-compose.yml          # Configuração principal dos containers
├── nginx/
│   └── nginx.conf             # Configuração base do Nginx
├── reverse-proxy/
│   └── default.conf           # Configuração do proxy reverso
├── static-portal/
│   ├── Dockerfile             # Container do portal estático
│   └── index.html             # Página principal do portal
├── portal/
│   └── wp-config.php          # Configuração do WordPress
└── README.md                  # Este arquivo
```

## Serviços

### 1. Reverse Proxy (Nginx)
- **Container**: cliente3-proxy
- **Porta**: 80
- **Função**: Roteamento de requisições para os serviços

### 2. Portal Estático
- **Container**: cliente3-static-portal
- **Rota**: `/portal/`
- **Função**: Página principal estática com navegação

### 3. CMS WordPress
- **Container**: cliente3-portal
- **Rota**: `/cms/`
- **Função**: Sistema de gerenciamento de conteúdo

### 4. Banco de Dados MySQL
- **Container**: cliente3-db
- **Função**: Armazenamento de dados do WordPress

## Como Executar

1. Navegue até o diretório do projeto:
   ```bash
   cd cliente3
   ```

2. Execute o Docker Compose:
   ```bash
   docker-compose up -d
   ```

3. Acesse os serviços:
   - Portal Principal: http://localhost/
   - Portal Estático: http://localhost/portal/
   - CMS WordPress: http://localhost/cms/

## Configuração do WordPress

Após a primeira execução, configure o WordPress acessando `/cms/` e seguindo o assistente de instalação.

## Parar os Serviços

```bash
docker-compose down
```

## Remover Volumes (dados)

```bash
docker-compose down -v
```

