FROM armhf/alpine:latest
MAINTAINER Jens Remus <jens.remus@gmail.com>

ENV SYNC_VERSION 2.4.5

RUN mkdir -p /opt/resilio-sync/bin /var/opt/resilio-sync

RUN apk add --no-cache --virtual .fetch-deps \
      ca-certificates \
      openssl \
      wget \
 \
 && apk add --no-cache libc6-compat \
 && wget -O /tmp/resilio-sync.tar.gz "https://download-cdn.resilio.com/$SYNC_VERSION/linux-armhf/resilio-sync_armhf.tar.gz" \
 && tar -xf /tmp/resilio-sync.tar.gz -C /opt/resilio-sync/bin rslsync \
 && rm /tmp/resilio-sync.tar.gz \
 \
 && apk del .fetch-deps

COPY resilio-sync.conf /etc/opt/

VOLUME /var/opt/resilio-sync

EXPOSE 8888 55555

ENTRYPOINT ["/opt/resilio-sync/bin/rslsync", "--nodaemon"]
CMD ["--log", "--config", "/etc/opt/resilio-sync.conf"]
