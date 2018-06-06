#!/bin/bash
# publish docker image to remote registry
# Author: shanyou@htyunwang.com
# Date: 2018/5/9
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORK_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)
source ${SCRIPT_DIR}/function.sh
pushd ${WORK_DIR}
namespace logBuild

############################# begin ##############################
declare BUILD_VER
gen_tag BUILD_VER

PUBLISH_TARGET=$1

if [[ -z "${PUBLISH_TARGET}" ]]; then
    subject=error Log input invaild for publish target
    throw "input invaild for publish target"
fi

Log begin build jar ${entry}
build_jar $PUBLISH_TARGET $BUILD_VER
if [[ "$?" != "0" ]]; then
    # build error with throw exception
    subject=error Log build error with build test fail
    throw "build error with build test fail"
fi

# build image
Log begin build docker image ${entry}
declare IMAGE_ID
build_image ${PUBLISH_TARGET} $BUILD_VER IMAGE_ID
if [[ "$?" != "0" ]]; then
    # build error with throw exception
    subject=error Log build error with build image fail
    throw "build error with build image fail"
fi

# copy build
Log begin copy build and tag publish ${entry}
copy_build ${PUBLISH_TARGET} $BUILD_VER
if [[ "$?" != "0" ]]; then
    # build error with throw exception
    subject=error Log build error with copy build fail
    throw "build error with copy build fail"
fi

# publish
Log begin publish image ${IMAGE_ID}
if [[ -z "IMAGE_ID" ]]; then
    subject=error Log build image fail with no imageid generated
    throw "build image fail with no imageid generated"
fi
publish_image_by_id ${IMAGE_ID}
