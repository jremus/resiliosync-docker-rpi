FROM arm32v7/debian:jessie-slim
MAINTAINER Jens Remus <jens.remus@gmail.com>

ENV SYNC_VERSION 2.5.9

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/resilio-sync/bin /var/opt/resilio-sync

RUN wget --progress=dot:mega -O /tmp/resilio-sync.tar.gz "https://download-cdn.resilio.com/$SYNC_VERSION/linux-armhf/resilio-sync_armhf.tar.gz" \
 && tar -xf /tmp/resilio-sync.tar.gz -C /opt/resilio-sync/bin rslsync \
 && rm /tmp/resilio-sync.tar.gz

COPY resilio-sync.conf /etc/opt/

VOLUME /var/opt/resilio-sync

EXPOSE 8888 55555

ENTRYPOINT ["/opt/resilio-sync/bin/rslsync", "--nodaemon"]
CMD ["--log", "--config", "/etc/opt/resilio-sync.conf"]
