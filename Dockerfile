FROM resin/rpi-raspbian:wheezy
MAINTAINER Jens Remus <jens.remus@gmail.com>

ENV BTSYNC_VERSION 1.4.111

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/btsync/bin /var/opt/btsync

RUN wget --progress=dot:mega -O /tmp/btsync.tar.gz "http://syncapp.bittorrent.com/$BTSYNC_VERSION/btsync_arm-$BTSYNC_VERSION.tar.gz" \
 && tar -xf /tmp/btsync.tar.gz -C /opt/btsync/bin btsync \
 && rm /tmp/btsync.tar.gz

COPY btsync.conf /etc/opt/

VOLUME /var/opt/btsync

EXPOSE 8888 55555

ENTRYPOINT ["/opt/btsync/bin/btsync", "--nodaemon"]
CMD ["--log", "--config", "/etc/opt/btsync.conf"]
