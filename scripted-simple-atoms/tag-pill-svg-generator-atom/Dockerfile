ARG SA_BASE_VERSION="latest"
FROM scriptedatom/ssa-base:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV TAG_PREFIX "sa"
ENV TAG_VALUE ""
ENV REPO_TARGET "/scripted-atom/repo"
ENV PILL_TEMPLATE "$WORKING_DIRECTORY/pill-template.svg"
ENV PILL_OUTPUT "$WORKING_DIRECTORY/pill-output.svg"

RUN apk update \
 && apk add git \
 && rm -rf /var/cache/apk/*

RUN mkdir ~/.ssh

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH
COPY version-template.svg $PILL_TEMPLATE
