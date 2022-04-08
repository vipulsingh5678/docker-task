FROM ubuntu:latest

ENV NODE_VERSION=16.13.0
RUN apt-get update \
    &&  apt-get install -y curl
RUN apt-get update\
    && curl -s https://deb.nodesource.com/setup_16.x | bash \
    && apt-get install nodejs -y


RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisord.conf
ENTRYPOINT ["supervisord","-c","/etc/supervisord.conf"]
