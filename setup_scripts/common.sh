#! /bin/bash

if [ -x"${BASH_VERSINFO}" == x"" ]
then
    echo "This script assumes/expects bash"
    exit 1
fi


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

function assert_truefalse() {
    local varname
    local value
    varname=$1
    value=\$$varname
    _ok=false
    if [ ${value} == true ]
    then
	ok=true
    fi
    if [ ${value} == false ]
    then
	ok=true
    fi

    if ! $ok
    then
	echo "Variable: ${varname} is not valid it is: ${value}"
	echo "It must be exactly 'true' or 'false'"
	exit 1
    fi
}

assert_truefalse _require_ve

_logfile=${_logfile-false}
assert_truefalse _logfile

if ${_logfile}
then
    # filename
    _log_filename=${HERE}/`basename ${0}`-${OPENCV_VERSION}.log
    #
    # remove old
    rm -f ${_log_filename}
    # start logging
    exec &> >(tee "$_log_filename")
    echo "#---------------------------"
    echo "# Logfile: " ${_log_filename}
    echo "# Logfile started: `date`"
    echo "# Working directory: `pwd`"
    echo "#---------------------------"
fi


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
