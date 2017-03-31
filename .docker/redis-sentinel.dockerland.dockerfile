FROM redis:latest

EXPOSE 6379 16379

ENTRYPOINT  ["redis-server","--appendonly","yes"]
# redis-sentinel
