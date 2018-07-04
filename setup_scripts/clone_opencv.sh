#! /bin/sh


HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=false
. ${SETUP_SCRIPT_DIR}/common.sh

assert "test x${OPENCV_VERSION} == xhead"


cd ${HERE}
for x in opencv opencv_contrib opencv_extra cvat
do
    clone_dir=${x}-${OPENCV_VERSION}
    rm -rf ${clone_dir}
    # we clone with depth=1 so we can have a fast checkout
    git clone --depth=1 https://github.com/opencv/${x}.git  ${clone_dir}
done


