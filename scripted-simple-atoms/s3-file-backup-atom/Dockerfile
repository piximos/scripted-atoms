ARG SA_BASE_VERSION="latest"
FROM scriptedatom/ssa-base:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk add curl \
 && apk add zip \
 && curl -O https://dl.minio.io/client/mc/release/linux-amd64/mc \
 && chmod +x mc \
 && mv ./mc /bin/mc \
 && rm -rf /var/cache/apk/*

ENV ZIP_FOLDERS "true"
ENV FOLDER_ADD_TIMESTAMP "true"
ENV FOLDER_TIMESTAMP_POSITION "suffix"
ENV DESTINATION_FOLDER "scripted-atom-dump"

RUN mc config host rm s3 \
 && mc config host rm gcs \
 && mc config host rm play \
 && mc config host rm local

