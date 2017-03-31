# redis. cluster mode.

FROM redis:latest

COPY ./.docker/config/redis.nodes.production.conf /config/nodes.conf

COPY ./.docker/config/redis.production.conf /usr/local/etc/redis/redis.conf

EXPOSE 6379 16379

ENTRYPOINT  ["redis-server", "/usr/local/etc/redis/redis.conf"]