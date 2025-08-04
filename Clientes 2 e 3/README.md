## Arquitetura

Baseado no Cliente 1 original, cada cliente possui:
- **Proxy Reverso (Nginx)**: Roteamento de requisições
- **Portal Estático**: Página principal com navegação
- **CMS WordPress**: Sistema de gerenciamento de conteúdo

## Estrutura do Projeto

```
clientes_replicados/
├── cliente2/                   # Projeto completo do Cliente 2
│   ├── docker-compose.yml
│   ├── nginx/
│   ├── reverse-proxy/
│   ├── static-portal/
│   ├── portal/
│   └── README.md
├── cliente3/                   # Projeto completo do Cliente 3
│   ├── docker-compose.yml
│   ├── nginx/
│   ├── reverse-proxy/
│   ├── static-portal/
│   ├── portal/
│   └── README.md
└── README.md                   # Este arquivo
```

## Diferenças entre Clientes

### Cliente 2 (Verde)
- Tema de cores: Verde (#2E8B57, #228B22)
- Emoji: 🌿
- Rotas: `/portal/` (estático) e `/cms/` (WordPress)

### Cliente 3 (Laranja)
- Tema de cores: Laranja (#FF6B35, #F7931E)
- Emoji: 🔥
- Rotas: `/portal/` (estático) e `/cms/` (WordPress)

## Como Executar

### Cliente 2
```bash
cd cliente2
docker-compose up -d
```
Acesse: http://localhost/

### Cliente 3
```bash
cd cliente3
docker-compose up -d
```
Acesse: http://localhost/

**Importante**: Execute apenas um cliente por vez, pois ambos usam a porta 80.


## Tecnologias Utilizadas

- **Docker & Docker Compose**: Containerização
- **Nginx**: Proxy reverso e servidor web
- **WordPress**: CMS
- **MySQL**: Banco de dados
- **HTML/CSS/JavaScript**: Portal estático

