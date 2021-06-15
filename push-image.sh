#!/bin/bash

PROJECT_NAME="vts"
REPO_NAME="soulteary/prebuilt-nginx-modules"
RELEASE_DIR="./docker";

for subVer in $RELEASE_DIR/*; do
    set -a
        . "$subVer/.env"
    set +a

    REPO_TAG="ngx-$NGINX_VERSION-$PROJECT_NAME-$MODULE_VERSION";

    if [ -f "$subVer/Dockerfile.alpine" ]; then
        BUILD_NAME="$REPO_NAME:$REPO_TAG-alpine"
        if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
            echo "Push: $BUILD_NAME";
            docker push $BUILD_NAME;
        fi
    fi

    if [ -f "$subVer/Dockerfile.debian" ]; then
        BUILD_NAME="$REPO_NAME:$REPO_TAG"
        if [[ "$(docker images -q $BUILD_NAME 2> /dev/null)" != "" ]]; then
            echo "Push: $BUILD_NAME";
            docker push $BUILD_NAME;
        fi
    fi

done
