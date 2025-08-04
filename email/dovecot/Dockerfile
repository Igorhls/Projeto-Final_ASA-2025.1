# Usar uma imagem base Debian estável e pequena
FROM debian:bullseye-slim

# Instalar o Dovecot e seus módulos IMAP
# O -y confirma a instalação automaticamente
RUN apt-get update && \
    apt-get install -y dovecot-imapd && \
    rm -rf /var/lib/apt/lists/*

# Criar o usuário e grupo para os e-mails virtuais.
# Isso evita a maioria dos problemas de permissão com os volumes.
RUN groupadd -g 5000 vmail && \
    useradd -u 5000 -g vmail -s /usr/bin/nologin vmail

# Copiar todos os arquivos de configuração do seu computador para a imagem.
# Esta é a etapa crucial que estava faltando!
# Ele copiará dovecot.conf, conf.d/, users/, etc.
COPY . /etc/dovecot/

# Garantir que o Dovecot tenha permissão para ler os arquivos de configuração.
RUN chown -R root:root /etc/dovecot && \
    chmod -R o-rwx /etc/dovecot

# Expor a porta do IMAPS (boa prática de documentação da imagem)
EXPOSE 993

# Comando para iniciar o Dovecot quando o contêiner rodar
CMD ["dovecot", "-F"]