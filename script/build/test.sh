#!/bin/bash
# test script
#
#set -x
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORK_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)
source ${SCRIPT_DIR}/function.sh
import util/log
# import util/tryCatch
# import util/exception
pushd ${WORK_DIR}

throw "Error test"
echo after throw
echo done!!!
