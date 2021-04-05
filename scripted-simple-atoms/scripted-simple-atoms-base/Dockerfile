FROM alpine
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ENV_TEMPLATE_PATH "/env-variables-template.json"
ENV RUNNER_FILE_PATH "/scripted-atom/runner.sh"

RUN apk update \
 && apk upgrade \
 && apk add bash \
 && apk add jq \
 && rm -rf /var/cache/apk/*

COPY env-variables-checker.sh /env-variables-checker.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY env-variables-template.json $ENV_TEMPLATE_PATH

WORKDIR /scripted-atom
COPY runner.sh $RUNNER_FILE_PATH

ENTRYPOINT /docker-entrypoint.sh