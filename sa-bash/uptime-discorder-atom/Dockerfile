ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-bash:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV DISCORD_SUCCESS_EMOJI ":warning:"
ENV DISCORD_FAILURE_EMOJI ":white_check_mark:"
ENV SA_IS_SLEEPER_SCRIPT "true"
ENV SA_SLEEP_DURATION "60"


COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH