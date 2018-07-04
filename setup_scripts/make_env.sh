#!/bin/bash

if [ x"${ENV_NAME}" == x"" ]
then
    ENV_NAME=cv
fi

# blow away old virtual env
rm -rf ${HOME}/.virtualenvs/${ENV_NAME}

# I only use Python3 
mkvirtualenv ${ENV_NAME} --system-site-packages -p python3

