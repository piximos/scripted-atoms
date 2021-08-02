ARG SA_BASE_IMAGE="alpine"
FROM ${SA_BASE_IMAGE} AS sa_base

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk upgrade \
 && apk add --no-cache bash jq curl\
 && rm -rf /var/cache/apk/*

ENV VALIDATE_ENV_VARIABLES "true"
ENV VALIDATE_VERBOSELY "false"
ENV ENV_TEMPLATE_PATH "/env-variables-template.json"
ENV WORKING_DIRECTORY "/scripted-atom"

COPY sa-base/docker-entrypoint.sh /docker-entrypoint.sh
COPY sa-base/env-variables-checker.sh /env-variables-checker.sh
COPY sa-base/env-variables-template.json $ENV_TEMPLATE_PATH

WORKDIR $WORKING_DIRECTORY

FROM sa_base AS sa_bash
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/runner.sh"
COPY sa-bash/runner.sh $RUNNER_FILE_PATH

ENTRYPOINT ["/docker-entrypoint.sh", "bash $RUNNER_FILE_PATH"]

FROM sa_base AS sa_gitter
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk upgrade \
 && apk add --no-cache git \
 && rm -rf /var/cache/apk/*


ENV ATOM_ROBOT_EMAIL "dhraief.youssef@gmail.com"
ENV ATOM_ROBOT_USERNAME "scripted-atom"

ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/runner.sh"
COPY sa-gitter/runner.sh $RUNNER_FILE_PATH
ENV PREFLIGHT_FILE_PATH "/preflight.sh"
COPY sa-gitter/preflight.sh "$PREFLIGHT_FILE_PATH"
ENV BASE_ENV_VARIABLES "/base-env-variables-template.json"
COPY sa-gitter/base-env-variables-template.json "$BASE_ENV_VARIABLES"

ENTRYPOINT ["/docker-entrypoint.sh", "bash $PREFLIGHT_FILE_PATH bash $RUNNER_FILE_PATH"]

FROM sa_base AS sa_s3
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

RUN apk update \
 && apk upgrade \
 && curl -O https://dl.minio.io/client/mc/release/linux-amd64/mc \
 && chmod +x mc \
 && mv ./mc /bin/mc \
 && rm -rf /var/cache/apk/*

ENV S3_CLIENT_PREFIX "atom"

ENV S3_URI ""
ENV S3_ACCESS_KEY ""
ENV S3_SECRET_KEY ""

ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/runner.sh"
COPY sa-s3/runner.sh $RUNNER_FILE_PATH
ENV PREFLIGHT_FILE_PATH "/preflight.sh"
COPY sa-s3/preflight.sh "$PREFLIGHT_FILE_PATH"
ENV BASE_ENV_VARIABLES "/base-env-variables-template.json"
COPY sa-s3/base-env-variables-template.json "$BASE_ENV_VARIABLES"

ENTRYPOINT ["/docker-entrypoint.sh", "bash $PREFLIGHT_FILE_PATH bash $RUNNER_FILE_PATH"]

FROM sa_base AS sa_python
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SCRIPTS_DIR "$WORKING_DIRECTORY/scripts"
ENV ADDITIONAL_SCRIPTS_DIR "/scripts"

ENV PREFLIGHT_FILE_PATH "/preflight.sh"
COPY sa-python/preflight.sh "$PREFLIGHT_FILE_PATH"
ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/app.py"
COPY sa-python/py-app.py $RUNNER_FILE_PATH
ENV BASE_ENV_VARIABLES "/base-env-variables-template.json"
COPY sa-python/base-env-variables-template.json "$BASE_ENV_VARIABLES"


ENTRYPOINT ["/docker-entrypoint.sh", "bash $PREFLIGHT_FILE_PATH"]

FROM sa_python AS sa_fastapi
MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ATOM_PORT 8420
ENV RUNNER_FILE_PATH "$WORKING_DIRECTORY/app.py"

ENV BASE_ENV_VARIABLES "/base-env-variables-template.json"
COPY sa-fastapi/base-env-variables-template.json "$BASE_ENV_VARIABLES"


COPY sa-fastapi/fast-app.py $RUNNER_FILE_PATH
COPY sa-fastapi/requirements.txt $WORKING_DIRECTORY

RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["/docker-entrypoint.sh", "uvicorn app:atom --host 0.0.0.0 --port \"$ATOM_PORT\""]