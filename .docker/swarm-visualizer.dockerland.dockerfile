FROM manomarks/visualizer:latest

EXPOSE 8080

VOLUME	/var/run/docker.sock

ENV     HOST=node-master PORT=8080

