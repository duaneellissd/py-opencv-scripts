#! /bin/bash

#---------------
# this is a bunch of common helper functions
# and steps used by the build scripts
#---------------

function assert() {
    if ! ${1}
    then
	echo "Assertion fails: ${1}"
	exit 1
    fi
}

function file_must_exist() {
    f_name=$1

    if [ ! -f $f_name ]
    then
	echo "Missing: $f_name"
	exit 1
    fi
}


function dir_must_exist() {
    d_name=$1

    if [ ! -d $d_name ]
    then
	echo "Missing: $d_name"
	exit 1
    fi
}


echo "test opencv version" >> /dev/null
if [ x"${OPENCV_VERSION}" == x"" ]
then
    OPENCV_VERSION=head
fi

assert "test x${_require_ve} == xtrue -o x${_require_ve} == xfalse"

# I only use python3
_python_exe=python3

echo "current-virtual-env: ${VIRTUAL_ENV-none}"
if ${_require_ve}
then
    if [ x"${VIRTUAL_ENV}" == x"" ]
    then
	echo "Missing Virtual Env!"
	exit 1
    fi
    PYTHON_EXE=${VIRTUAL_ENV}/bin/${_python_exe}
else
    if [ x"${VIRTUAL_ENV}" != x"" ]
    then
	echo "Should not have Virtual Env!"
	exit 1
    fi
    PYTHON_EXE=`which ${_python_exe}`
fi

# verify python is executable
if [ ! -x ${PYTHON_EXE} ]
then
    echo "Missing Python executable: ${PYTHON_EXE}"
fi
       
