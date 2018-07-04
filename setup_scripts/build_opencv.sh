#! /bin/bash

set -e

HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=true
. ${SETUP_SCRIPT_DIR}/common.sh

cd ${HERE}

IMAGE_ROOT=${HERE}

BUILD_DIR=${IMAGE_ROOT}/build-${OPENCV_VERSION}

OPENCV_SRC=${IMAGE_ROOT}/opencv-${OPENCV_VERSION}

tst_filename=${OPENCV_SRC}/modules/core/include/opencv2/core.hpp
file_must_exist $tst_filename

# blow away the old build directory
rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

# create cmake command line
ARGS=""
ARGS="${ARGS} -D CMAKE_INSTALL_PREFIX=${VIRTUAL_ENV}"
ARGS="${ARGS} -D CMAKE_BUILD_TYPE=DEBUG"
ARGS="${ARGS} -D INSTALL_PYTHON_EXAMPLES=ON"
ARGS="${ARGS} -D INSTALL_C_EXAMPLES=OFF"
ARGS="${ARGS} -D OPENCV_EXTRA_MODULES_PATH=${IMAGE_ROOT}/opencv_contrib-${OPENCV_VERSION}/modules"
ARGS="${ARGS} -D PYTHON_EXECUTABLE=${VIRTUAL_ENV}/bin/python3"
ARGS="${ARGS} -D BUILD_EXAMPLES=ON"
ARGS="${ARGS} ../opencv-${OPENCV_VERSION}"

# execute cmake
set -x
cmake ${ARGS}
set +x

cd ${BUILD_DIR}
make all

cd ${BUILD_DIR}
make install
