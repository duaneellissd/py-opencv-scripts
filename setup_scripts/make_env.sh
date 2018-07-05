#!/bin/bash

if [ x${1} == x ]
then
    echo "Usage: ${0} ENVNAME"
    exit 1
fi

ENV_NAME=${1}

# blow away old virtual env
echo "Remove old ENV: ${ENV_NAME}"
set -x
rm -rf "${HOME}/.virtualenvs/${ENV_NAME}"
set +x

# I only use Python3
export WORKON_HOME=${HOME}/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv ${ENV_NAME} --system-site-packages -p python3

