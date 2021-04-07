FROM scriptedatom/ssa-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk add curl \
 && rm -rf /var/cache/apk/*

ENV SLACK_WEBHOOK_URL ""
ENV SLACK_COLOR "#87ebaa"
ENV SLACK_MSG ""

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH