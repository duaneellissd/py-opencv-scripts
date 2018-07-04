#! /bin/sh

HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=false
. ${SETUP_SCRIPT_DIR}/common.sh
cd ${HERE}

wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

sudo pip3 install virtualenv virtualenvwrapper
sudo rm -rf ${HERE}/get-pip.py ${HOME}/.cache/pip



