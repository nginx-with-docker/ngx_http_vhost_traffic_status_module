#!/bin/bash

REPO_NAME="soulteary/prebuilt-nginx-modules"
tag="vts";

set -a
    . "docker/.env"
set +a


if [ -f "docker/Dockerfile.alpine" ]; then
    BUILD_NAME="$REPO_NAME:$tag-$NGINX_VERSION-alpine"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
        echo "Build: $BUILD_NAME";
        BUILD_ARGS=$(tr '\n' ';' < "docker/.env" | sed 's/;$/\n/' | sed 's/^/ --build-arg /' | sed 's/;/ --build-arg /g')
        docker build $BUILD_ARGS --tag $BUILD_NAME -f docker/Dockerfile.alpine .
    fi
fi

if [ -f "docker/Dockerfile.debian" ]; then
    BUILD_NAME="$REPO_NAME:$tag-$NGINX_VERSION"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" == "" ]]; then
        echo "Build: $BUILD_NAME";
        BUILD_ARGS=$(tr '\n' ';' < "docker/.env" | sed 's/;$/\n/' | sed 's/^/ --build-arg /' | sed 's/;/ --build-arg /g')
        docker build $BUILD_ARGS --tag $BUILD_NAME -f docker/Dockerfile.debian .
    fi
fi
