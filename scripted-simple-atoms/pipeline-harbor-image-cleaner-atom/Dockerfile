FROM scriptedatom/ssa-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk add curl \
 && rm -rf /var/cache/apk/*

ENV SA_DELETE_UNTAGGED_ARTIFACTS "true"


COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH