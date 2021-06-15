#!/bin/bash

REPO_NAME="soulteary/prebuilt-nginx-modules";
tag="vts";

set -a
    . "docker/.env"
set +a


if [ -f "docker/Dockerfile.alpine" ]; then
    BUILD_NAME="$REPO_NAME:$tag-$NGINX_VERSION-alpine"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
        echo "Push: $BUILD_NAME";
        docker push $BUILD_NAME;
    fi
fi

if [ -f "docker/Dockerfile.debian" ]; then
    BUILD_NAME="$REPO_NAME:$tag-$NGINX_VERSION"
    if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
        echo "Push: $BUILD_NAME";
        docker push $BUILD_NAME;
    fi
fi

