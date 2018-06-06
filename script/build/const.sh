#!/bin/bash
# constants variable defined for build
# Author: shanyou@htyunwang.com
# Date: 2018/5/9
#
REMOTE_REG=${DOCKER_REG_REMOTE:-"registry.htres.cn"}
IMAGE_ROOT=yunlu
# wechat api url with source in http://172.17.60.106/devteam/BDE/tree/V2/micro-service/wxmessage
WECHAT_API=http://registry.doc.htyunlu.com:8888/wechat/message
# build template directory
BUILD_DIR=out
# artifact directory that java build result. usually is "build" in project dir
ART_DIR=build

# default publish dir
#  mount -t cifs //172.17.60.104/log-service_release /mnt/log-service_release -o username=builder,password=1234.asd,uid=jenkins,gid=jenkins
PUBLISH_DIR=/mnt/log-service_release
PUBLISH_LATEST=latest
