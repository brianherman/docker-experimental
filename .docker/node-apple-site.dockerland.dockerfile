FROM node:latest

RUN npm install -g pm2

COPY    ./microservices/apple-site /usr/src/app

WORKDIR /usr/src/app

EXPOSE 		8080

ENTRYPOINT ["pm2", "start", "server.js","--watch","--no-daemon"]
