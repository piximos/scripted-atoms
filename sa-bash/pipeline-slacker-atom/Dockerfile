ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-bash:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SLACK_WEBHOOK_URL ""
ENV SLACK_COLOR "#87ebaa"
ENV SLACK_MSG ""
ENV SLACK_ARTIFACTS ""

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH