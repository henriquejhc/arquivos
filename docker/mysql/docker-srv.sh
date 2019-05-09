#!/bin/bash
DOCKER="docker"

DNS1="172.23.1.1"
DNS2="172.23.1.10"
DOMAIN="softplan.com.br"
DOCKER_NETWORK="--dns=${DNS1} --dns=${DNS2} --dns-search=${DOMAIN}"

CONTAINER_NAME="mysql-docker"
DOCKER_IMAGE="mysql/mysql-server"
DOCKER_IMAGE_VERSION="latest"
DOCKER_PATH_VOLUME="/home/cardoso/apps/mysql/"

case "$1" in
   run)
        echo "Criando o Container: $CONTAINER_NAME"
        ${DOCKER} run -d --name $CONTAINER_NAME \
            --hostname=$CONTAINER_NAME \
            --env-file ./environment.env \
            -v $DOCKER_PATH_VOLUME:/var/lib/mysql \
            -p 6603:3306 $DOCKER_NETWORK $DOCKER_IMAGE:$DOCKER_IMAGE_VERSION
        exit 0
        ;;
   start)
        echo "Iniciando o Container: $CONTAINER_NAME"
        ${DOCKER} start $CONTAINER_NAME
        exit 0
        ;;
   stop)
        echo "Parando o Container: $CONTAINER_NAME"
        ${DOCKER} stop $CONTAINER_NAME
        exit 0
        ;;
   restart)
    echo "Parando o Container: $CONTAINER_NAME"
      ${DOCKER} stop $CONTAINER_NAME
    wait 5
    echo "Iniciando o Container: $CONTAINER_NAME"
      ${DOCKER} start $CONTAINER_NAME
    exit 0
        ;;
   logs)
        ${DOCKER} logs -f $CONTAINER_NAME
        exit 0
        ;;
   top)
        ${DOCKER} stats $CONTAINER_NAME
        exit 0
        ;;
   sh)
        ${DOCKER} exec -it $CONTAINER_NAME /bin/bash
        exit 0
        ;;
   rm)  echo "Removendo Container: $CONTAINER_NAME"
        ${DOCKER} rm $CONTAINER_NAME
        exit 0
        ;;
   *)
        echo "Informe um dos parametros: run, start, stop, restart, logs, top, sh, rm"
        ;;
esac
