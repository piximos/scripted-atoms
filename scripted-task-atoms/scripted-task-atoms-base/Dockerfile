FROM python:3

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ST_IS_SLEEPER_SCRIPT "false"
ENV ST_SLEEP_DURATION ""

WORKDIR /scripted-atom

VOLUME /validators

COPY scripted-atom /scripted-atom
RUN pip install --no-cache-dir -r requirements.txt

COPY base-config-validator.py /base-config-validator.py
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh