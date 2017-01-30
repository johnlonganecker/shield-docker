FROM postgres:9.6
ENV DEBIAN_FRONTEND noninteractive
ENV SHIELD_VERSION v0.9.0

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/starkandwayne/shield/releases/download/${SHIELD_VERSION}/shield-server-linux-amd64.tar.gz
RUN tar xzf shield-server-linux-amd64.tar.gz

WORKDIR /shield-server-linux-amd64

RUN mkdir bin
RUN mkdir -p /usr/share/shield/webui

RUN cp agent/shield-agent bin/
RUN cp cli/shield bin/
RUN cp daemon/shieldd bin/
RUN cp daemon/shield-schema bin/
RUN cp daemon/shield-pipe bin/
RUN cp -R webui/* /usr/share/shield/webui

COPY ./daemon/shieldd.conf .
COPY ./id_rsa .
COPY ./daemon/wait-for-it.sh .
COPY ./daemon/start-shield.sh .

EXPOSE 8080

CMD ./start-shield.sh
