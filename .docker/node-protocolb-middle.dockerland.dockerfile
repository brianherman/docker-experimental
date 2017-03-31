FROM node:latest

# testing. should use package.json in node
RUN npm install -g pm2

COPY    ./microservices/middle-api /usr/src/app

WORKDIR /usr/src/app

EXPOSE 		8080

ENTRYPOINT ["pm2", "start", "server.js","--watch","--no-daemon"]
