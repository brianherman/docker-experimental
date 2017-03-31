NOTE-MAK: --> insert container network diagram here <--

NOTE-MAK: documentation is still being updated and is not complete...

# Docker-Experimental

This project tests basic container applications using custom Dockerfile images and Docker Compose configurations.

NOTE: this project still uses the legacy V2 compose file.

# Instructions
the applications are broken in multiple compose files
all configurations and volume mounts have been already taken care of

docker-compose-volumes-networks.yml

tier0-monitoring.yml
tier1-redis.yml
tier2-proxy.yml
tier3-api.yml
tier3-node-pm2.yml
tier3-splunk.yml
tier4-proxy.yml

Run docker CLI commands
docker-compose -f <file_name> <up|down>
from tier0 -> tier4

while you are building and running the containers
Access weaveworks scope to visualize how the containers interact with each other on the network.

You can visit the web services on the  outside port.
These requests route through the microservice.

Have fun.

# Motivation
Most of these containers were used to grasp better understanding of
1. how Docker handles DNS internally
2. subnets and vxlans
3. proxy
4. cache
5. web api
6. databases
7. Dockerfile, images, registry, and swarm.
8. CI
9. analytics
10. application monitoring
11. clusters
12. api load balancing
13. port security and network isolation

## Technologies Used
Node
PM2
Redis Cluster (Master-Slave)
Redis TwemProxy
Nginx
Postgres
Mongo

## Still Testing
Passport.js
Swarm Visualizer
Celery
Jenkins
ELK
etcd

