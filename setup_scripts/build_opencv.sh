#! /bin/bash

set -e

HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=true
_logfile=true
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

# make sure nump and scipy are present.
$PYTHON_EXE -c "import numpy; import scipy"

# create cmake command line
ARGS=""
ARGS="${ARGS} -D CMAKE_INSTALL_PREFIX=${VIRTUAL_ENV}"
ARGS="${ARGS} -D CMAKE_BUILD_TYPE=DEBUG"
ARGS="${ARGS} -D INSTALL_PYTHON_EXAMPLES=ON"
ARGS="${ARGS} -D INSTALL_C_EXAMPLES=OFF"
ARGS="${ARGS} -D OPENCV_EXTRA_MODULES_PATH=${IMAGE_ROOT}/opencv_contrib-${OPENCV_VERSION}/modules"
ARGS="${ARGS} -D PYTHON_EXECUTABLE=${VIRTUAL_ENV}/bin/python3"
ARGS="${ARGS} -D BUILD_EXAMPLES=ON"
if [ x"${OPENCV_VERSION}" != x"head" ]
then
    # See: https://github.com/opencv/opencv/issues/9549
    ARGS="${ARGS} -D BUILD_PROTOBUF=OFF -D PROTOBUF_UPDATE_FILES=ON"
    ARGS="${ARGS} -D Protobuf_PROTOC_EXECUTABLE=`which protoc`"
    # opencv-3.3.0/modules/dnn/src/tensorflow/tf_importer.cpp:756:72: error: no match for ‘operator[]’
    # Thus I am disabling DNN
    # As I can see it is an interface to Google TensorFlow
    # that is not currently a goal - and besides this is fixed in head.
    ARGS="${ARGS} -D BUILD_opencv_dnn=OFF"
    #http://answers.opencv.org/question/138047/opencv-32-includes-libmirprotobuf-and-protobuf-26-which-is-conflicting-with-protobuf-31/
    ARGS="${ARGS} -D WITH_GTK=OFF -D WITH_GTK_2_X=OFF -D WITH_QT=ON"
fi
   
ARGS="${ARGS} ../opencv-${OPENCV_VERSION}"


# execute cmake
set -x
cmake ${ARGS}
set +x

cd ${BUILD_DIR}
make all

cd ${BUILD_DIR}
make install

       
echo "#---------------------------"
echo "# Build complete: `date`"
echo "# Working directory: `pwd`"
echo "#---------------------------"
