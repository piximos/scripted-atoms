#!/bin/bash

echo "Deleting local images"
docker rmi "${IMAGE_NAME}:latest"
docker rmi "${IMAGE_NAME}:${IMAGE_VERSION}"