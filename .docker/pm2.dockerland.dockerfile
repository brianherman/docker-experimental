FROM keymetrics/pm2-docker-alpine:latest

# Copy custom nginx config
COPY ./.docker/config/pm2.production.yml /process.yml

# Expose ports
EXPOSE 80 443 43554

# /usr/lib/node_modules/pm2/lib/API.js:831
#   if (config.deploy)
#             ^
# 2016-09-26T00:12:27.688251884Z 
# TypeError: Cannot read property 'deploy' of null
#     at API._startJson (/usr/lib/node_modules/pm2/lib/API.js:831:13)
#     at API.start (/usr/lib/node_modules/pm2/lib/API.js:295:10)
#     at run (/usr/lib/node_modules/pm2/bin/pm2-docker:72:7)
#     at /usr/lib/node_modules/pm2/bin/pm2-docker:52:7
#     at /usr/lib/node_modules/pm2/lib/API.js:141:14
#     at /usr/lib/node_modules/pm2/lib/API/Modules/Modularizer.js:282:17
#     at /usr/lib/node_modules/pm2/node_modules/async/lib/async.js:52:16
#     at replenish (/usr/lib/node_modules/pm2/node_modules/async/lib/async.js:314:29)
#     at /usr/lib/node_modules/pm2/node_modules/async/lib/async.js:330:15
#     at Object.async.forEachLimit.async.eachLimit (/usr/lib/node_modules/pm2/node_modules/async/lib/async.js:220:35)