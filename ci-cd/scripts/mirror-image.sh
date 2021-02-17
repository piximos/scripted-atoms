#!/bin/bash

set -x # echo on

docker pull "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}"
docker tag "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}" "${IMAGE_NAME}:${IMG_TAG}"
docker push "${IMAGE_NAME}:${IMG_TAG}"