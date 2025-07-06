#!/bin/bash

PROJECT_NAME="isp-project"

function start() {
    echo "Iniciando infraestrutura ISP..."
    sudo docker compose -p "$PROJECT_NAME" up -d --build
    echo " Todos os serviços foram iniciados com sucesso."
}

function stop() {
    echo "Parando containers..."
    sudo docker compose -p "$PROJECT_NAME" down
    echo " Todos os containers foram parados."
}

function restart() {
    echo "Reiniciando containers..."
    stop
    start
}

function logs() {
    echo "Exibindo logs dos serviços..."
    sudo docker compose -p "$PROJECT_NAME" logs -f --tail=100
}

function status() {
    echo " Status dos containers:"
    sudo docker ps --filter "name=${PROJECT_NAME}_"
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    logs)
        logs
        ;;
    status)
        status
        ;;
    *)
        echo "Uso: $0 {start|stop|restart|logs|status}"
        exit 1
        ;;
esac
