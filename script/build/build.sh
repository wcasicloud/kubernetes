#!/bin/bash
# build script for uc
# Author: shanyou@htyunwang.com
# Date: 2018/5/9
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORK_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)
source ${SCRIPT_DIR}/function.sh
pushd ${WORK_DIR}
namespace logBuild
############################ begin ###########################
declare BUILD_VER
gen_tag BUILD_VER

WITH_TEST=${BUILD_WITH_TEST:-}

GRPC_SERVER_FOLDER=${WORK_DIR}/log-common/log-grpc-core
LOG_API_FOLDER=${WORK_DIR}/log-web/log-api


#grpc server
cd ${GRPC_SERVER_FOLDER}
#build grpc server jar
Log begin build log-grpc-server
gradle clean
gradle fatCapsule

#build image
Log begin generate grpc-server docker image
declare LOG_GRPC_IMAGE_ID
build_image ${GRPC_SERVER_FOLDER} $BUILD_VER LOG_GRPC_IMAGE_ID
#copy build
Log begin copy build
copy_build ${GRPC_SERVER_FOLDER} $BUILD_VER



#log api
cd ${LOG_API_FOLDER}
#build log api jar
Log begin build log-api
build_jar ${LOG_API_FOLDER} BUILD_VER

#build image
Log begin generate log-api docker image
declare LOG_API_IMAGE_ID
build_image ${LOG_API_FOLDER} $BUILD_VER LOG_API_IMAGE_ID
#copy build
Log begin copy build
copy_build ${LOG_API_FOLDER} $BUILD_VER


########################### end ################################
popd
