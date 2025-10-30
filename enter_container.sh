#!/usr/bin/env bash

TAG="latest"
version_regex=v[[:digit:]]+[.][[:digit:]]+[.][[:digit:]][-[:alpha:]]*

usage() {
    echo "Usage: $0 --tag <string>"
    echo "    where:"
    echo "        -t | --tag <version> is 'latest' or a version number like 'v1.0.0'; default is 'latest'"
    exit 1
}

VARS=$(getopt -o "t:" --long "tag:" -- "$@")
eval set -- "$VARS"
unset VARS

while true; do
    case "$1" in
    -t | --tag )
        TAG=$2;
        shift 2
        [[ $TAG == "latest" || $TAG =~ ^${version_regex}$ ]] || usage
        ;;
    -- ) shift;
        break
        ;;
    * )
        usage
        ;;
    esac
done

xhost + local:docker
echo "Using tag: ${TAG}"
WORKDIR="/home/developer"
docker run --rm --interactive --tty --privileged=true --network=host --env DISPLAY=$DISPLAY \
    --mount source=/tmp/.X11-unix,destination=/tmp/.X11-unix,type=bind,readonly \
    --mount source=${PWD},destination=${WORKDIR},type=bind \
    --mount source=/dev/bus/usb/,destination=/dev/bus/usb/,type=bind \
    --mount source=~/.Xilinx/,destination=/home/developer/.Xilinx/,type=bind \
    --workdir ${WORKDIR} \
    orbitalmicro/vivado-2018.3:${TAG} bash -i
