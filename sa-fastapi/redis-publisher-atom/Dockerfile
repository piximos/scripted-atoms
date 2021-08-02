ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-fastapi:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SA_REDIS_HOST ""
ENV SA_REDIS_PORT 6379
ENV SA_REDIS_PASSWORD ""

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY scripted-atom /scripted-atom

