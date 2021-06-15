ARG SA_BASE_VERSION="latest"
FROM scriptedatom/ssa-base:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk add curl \
 && rm -rf /var/cache/apk/*

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH