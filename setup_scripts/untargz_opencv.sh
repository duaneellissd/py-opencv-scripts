#! /bin/sh

HERE=`pwd`
SETUP_SCRIPT_DIR=`dirname ${0}`
_require_ve=false
. ${SETUP_SCRIPT_DIR}/common.sh
cd ${HERE}

# die if something goes wrong
set -e

parts="opencv opencv_contrib opencv_extra"

# unpack components
for x in $parts
do
    base_filename=${x}-${OPENCV_VERSION}
    tgz_filename=${HERE}/tarballs/${base_filename}.tar.gz
    if [ ! -f ${tgz_filename} ]
    then
	echo "Missing: ${tgz_filename}"
	exit 1
    fi
    echo "Unpacking: ${base_filename}"
    rm -rf ${base_filename}
    tar xfz ${tgz_filename}
    if [ ! -d ${base_filename} ]
    then
	echo "Unpack error, directory: ${base_filename} does not exist"
	exit 1
    fi
done

echo "Unpacked: OpenCV version ${OPENCV_VERSION}"

