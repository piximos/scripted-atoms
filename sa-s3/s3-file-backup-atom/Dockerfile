ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-s3:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk add zip \
 && rm -rf /var/cache/apk/*

ENV ZIP_FOLDERS "true"
ENV FOLDER_ADD_TIMESTAMP "true"
ENV FOLDER_TIMESTAMP_POSITION "suffix"
ENV DESTINATION_FOLDER "scripted-atom-dump"

RUN mc config host rm s3 \
 && mc config host rm gcs \
 && mc config host rm play \
 && mc config host rm local

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH