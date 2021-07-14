FROM alpine

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ENV_TEMPLATE_PATH "/env-variables-template.json"
ENV WORKING_DIRECTORY "/scripted-atom"
ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/runner.sh"

RUN apk update \
 && apk upgrade \
 && apk add bash \
 && apk add jq \
 && rm -rf /var/cache/apk/*

COPY env-variables-checker.sh /env-variables-checker.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY env-variables-template.json $ENV_TEMPLATE_PATH

WORKDIR $WORKING_DIRECTORY
#COPY runner.sh $RUNNER_FILE_PATH

ENTRYPOINT /docker-entrypoint.sh

ONBUILD RUN apk update \
 && apk upgrade