DNS1="172.23.1.1"
DNS2="172.23.1.10"
DOMAIN="softplan.com.br"

DOCKER_NETWORK="--dns=${DNS1} --dns=${DNS2} --dns-search=${DOMAIN}"

#docker="/usr/bin/docker"
#docker_run="/usr/bin/docker run -d"
#docker_network="--hostname=$docker_name"
docker_logs="--log-opt max-size=10m --log-opt max-file=5"

DOCKER="docker"
DOCKER_IMAGE="nginx"
DOCKER_IMAGE_VERSION="1.12-alpine"

CONTAINER_NAME="nginx-docker"
NGINX_CONFIG_PATH="/home/cardoso/dev/docker/nginx-docker/config/nginx-default.conf"

DOCKER_RUN_CMD="$DOCKER run  --name $CONTAINER_NAME $DOCKER_NETWORK -v $NGINX_CONFIG_PATH:/etc/nginx/nginx.conf:ro -d -p 80:80 -p 8000:8000 $DOCKER_IMAGE:$DOCKER_IMAGE_VERSION "

case "$1" in
  run)
    echo "Criando o Container: $CONTAINER_NAME"
    echo "$docker_run_cmd"
    $DOCKER_RUN_CMD
    exit 0
  ;;
  start)
    echo "Iniciando o Container: $CONTAINER_NAME"
    $DOCKER start $CONTAINER_NAME
    exit 0
  ;;
  stop)
    echo "Parando o Container: $CONTAINER_NAME"
    $DOCKER stop $CONTAINER_NAME
    exit 0
  ;;
  reset)
    echo "Parando o Container: $CONTAINER_NAME"
    $DOCKER stop $CONTAINER_NAME
    wait 5
    echo "Removendo o Container: $CONTAINER_NAME"
    $DOCKER rm $CONTAINER_NAME
    wait 5
    echo "Iniciando o Container: $CONTAINER_NAME"
    $DOCKER_RUN_CMD
    exit 0
  ;;
  logs)
    $DOCKER logs -f $CONTAINER_NAME
    exit 0
  ;;
  top)
    $DOCKER stats $CONTAINER_NAME
    exit 0
  ;;
  sh)
    $DOCKER exec -it $CONTAINER_NAME /bin/bash
    exit 0
  ;;
  rm)
    echo "Removendo Container: $CONTAINER_NAME"
    $DOCKER rm $CONTAINER_NAME
    exit 0
  ;;
  *)
    echo "Informe um dos parametros: run, start, stop, restart, logs, top, sh, rm"
  ;;
esac
