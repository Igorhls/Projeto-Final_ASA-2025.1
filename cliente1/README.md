# Projeto Cliente1 - Plataforma com Proxy Reverso, Portal, Hotsite e Sistema de Assinatura Digital

Este projeto é uma infraestrutura em containers Docker baseada em microserviços com foco na entrega de uma solução de hotsite, portal (WordPress) e sistema de assinatura digital (Sign App/API), integrados por um proxy reverso com Nginx.

## 🌐 Estrutura do Projeto

O projeto é composto por:

- **Proxy Reverso Nginx**: Roteia requisições para os serviços.
- **Portal (WordPress)**: Interface administrativa e site institucional.
- **Hotsite**: Página inicial com chamadas para o portal e Sign App.
- **Sign App**: Frontend da aplicação de assinatura digital.
- **Sign API**: Backend da aplicação de assinatura digital.
- **Banco de Dados PostgreSQL (cliente1-db)**: Suporte ao WordPress.
- **Banco de Dados PostgreSQL (sign-db)**: Suporte à Sign API.

## 🔁 Roteamento via Nginx

| Caminho                    | Serviço direcionado             |
|---------------------------|---------------------------------|
| `http://localhost/portal` | WordPress                       |
| `http://localhost/hotsite`| Hotsite estático                |
| `http://localhost/sign`   | Sign App (Frontend)             |
| `/api` (interno)          | Sign API (Backend REST)         |

## 📦 Tecnologias Utilizadas

- Docker e Docker Compose
- Nginx (como reverse proxy)
- WordPress
- PostgreSQL
- Node.js / Express (Sign API)
- Vue.js ou React (Sign App)
- HTML/CSS (Hotsite)


