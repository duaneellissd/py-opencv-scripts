#! /bin/bash


HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=false
. ${SETUP_SCRIPT_DIR}/common.sh
cd ${HERE}

for PIP in pip2 pip3
do
    sudo ${PIP} install markdown
    sudo ${PIP} install numpy
    sudo ${PIP} install scipy
    sudo ${PIP} install markdown
    sudo ${PIP} install h5py
    sudo ${PIP} install scikit-image
    sudo ${PIP} install dlib
    sudo ${PIP} JSON_minify
done
