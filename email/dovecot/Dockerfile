FROM debian:bullseye

RUN apt update && apt install -y dovecot-imapd dovecot-pop3d mailutils net-tools

COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY users/virtual_users /etc/dovecot/users

RUN chmod 640 /etc/dovecot/users
RUN mkdir -p /mail && chown -R 5000:5000 /mail
RUN useradd -u 5000 -d /mail vmail

# Garante que o arquivo de log existe
RUN touch /var/log/dovecot.log /var/log/dovecot-info.log

EXPOSE 143 993

CMD ["dovecot", "-F"]

