#!/bin/bash
# run uc service in docker
CONTAINER_NAME_GRPC=loggrpc
REMOTE_IMAGE_GRPC=registry.htres.cn/yunlu/log-grpc-core:latest
PORT_GRPC=10004
docker rm -f ${CONTAINER_NAME_GRPC}
docker run -d --name ${CONTAINER_NAME_GRPC} -e UC_CONF=release -p ${PORT_GRPC}:10004 ${REMOTE_IMAGE_GRPC}

CONTAINER_NAME_API=logapi
REMOTE_IMAGE_API=registry.htres.cn/yunlu/log-api:latest
PORT_API=10003
docker rm -f ${CONTAINER_NAME_API}
docker run -d --name ${CONTAINER_NAME_API} -e UC_CONF=release -p ${PORT_API}:10003 ${REMOTE_IMAGE_API}


