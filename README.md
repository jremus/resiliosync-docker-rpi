# Dockerfile to run Resilio Sync on Raspberry Pi

## How-To Build

```
docker build -t resilio-sync .
```

## How-To Run

```
docker run -d \
	--restart=unless-stopped \
	-p 8888:8888 \
	-p 55555:55555 \
	--hostname="$HOSTNAME-docker-resilio-sync" \
	-v "/etc/localtime":"/etc/localtime":ro \
	-v resilio-sync-data:/var/opt/resilio-sync \
	-v /mnt/hd1:/mnt/hd1 \
	--name="resilio-sync" \
	resilio-sync:latest
```
