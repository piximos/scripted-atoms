ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-bash:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SA_DELETE_UNTAGGED_ARTIFACTS "true"


COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH