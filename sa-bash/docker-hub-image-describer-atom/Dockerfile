ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-bash:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV EXIT_GRACEFULLY "true"
ENV DOCKER_USERNAME ""
ENV DOCKER_PASSWORD ""
ENV DOCKER_IMAGE_NAME ""
ENV README_FILE_PATH ""

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH