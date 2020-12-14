FROM python:3

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

WORKDIR /scripted-atom

VOLUME /validators

ENV ATOM_PORT 8420

EXPOSE $ATOM_PORT

COPY scripted-atom /scripted-atom
RUN pip install --no-cache-dir -r requirements.txt

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh