FROM node:latest

# testing. should use package.json in node
RUN npm install -g pm2 express

# server.js not working
COPY    ./.docker/server.js /usr/src/app/server.js
# COPY	./public /usr/src/app

WORKDIR /usr/src/app

EXPOSE 		8080

# take the web service down if it's unhealthy
HEALTHCHECK --timeout=1s --interval=1s --retries=3 \
  CMD curl -s --fail http://localhost:80/ || exit 1

#ENTRYPOINT ["node", "server.js"]

ENTRYPOINT ["pm2", "start", "server.js","--watch","--no-daemon"]
# pm2 link pkzvud1wd23qa12 ucyduihnl2alvlq node

# how to do this because node is listening?