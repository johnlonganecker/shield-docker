FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/starkandwayne/shield/releases/download/v0.8.3/shield-server-linux-amd64.tar.gz
RUN tar xzf shield-server-linux-amd64.tar.gz

WORKDIR /shield-server-linux-amd64

RUN mkdir bin
RUN mkdir /webui

RUN cp agent/shield-agent bin/
RUN cp cli/shield bin/
RUN cp daemon/shieldd bin/
RUN cp daemon/shield-schema bin/
RUN cp daemon/shield-pipe bin/

## TODO REMOVE ??
# RUN cp -R webui             webui

COPY ./shieldd.conf .
COPY ./id_rsa .
COPY ./wait-for-it.sh .
COPY ./start-shield.sh .
COPY ./webui /usr/share/shield/webui

EXPOSE 8080

CMD ./start-shield.sh
