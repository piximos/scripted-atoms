FROM registry.gitlab.com/piximos/scripted-atoms/scripted-task-atoms-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ST_IS_SLEEPER_SCRIPT "true"
ENV ST_SLEEP_DURATION 600

ENV ST_ADD_TIMESTAMP "true"
ENV ST_TIMESTAMP_FORMAT "%Y-%m-%d"

ENV ST_BUCKET_ENDPOINT ""
ENV ST_BUCKET_ACCESS_KEY ""
ENV ST_BUCKET_SECRET_KEY ""
ENV ST_BUCKET_NAME ""

ENV ST_BACKUP_LOCATION ""
ENV ST_S3_LOCATION ""


COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY config-validator.py /validators/config-validator.py
COPY scripted-atom /scripted-atom
