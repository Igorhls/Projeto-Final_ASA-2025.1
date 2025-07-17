FROM debian:bullseye

RUN apt update && apt install -y postfix mailutils

COPY main.cf /etc/postfix/main.cf
COPY vmailbox /etc/postfix/vmailbox

RUN mkdir -p /mail && chown -R 5000:5000 /mail
RUN useradd -u 5000 -d /mail vmail
RUN postmap /etc/postfix/vmailbox

EXPOSE 25 587

CMD ["postfix", "start-fg"]

