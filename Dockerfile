FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/starkandwayne/shield/releases/download/v0.8.1/shield-server-linux-amd64.tar.gz
RUN tar xzf shield-server-linux-amd64.tar.gz

WORKDIR /shield-server-linux-amd64

RUN mkdir bin

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

#RUN /shield-server-linux-amd64/daemon/shield-schema -t postgres -d postgres://postgres:postgres@postgres:5432/shield

#CMD /shield-server-linux-amd64/daemon/shieldd -c shieldd.conf --log-level info

 CMD ./start-shield.sh
