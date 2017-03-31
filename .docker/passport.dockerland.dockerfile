FROM node:latest

# testing. should use package.json in node
RUN npm install passport

COPY    ./microservices/backend-api /usr/src/app

WORKDIR /usr/src/app

EXPOSE 		8080

ENTRYPOINT ["pm2", "start", "server.js","--watch","--no-daemon"]
