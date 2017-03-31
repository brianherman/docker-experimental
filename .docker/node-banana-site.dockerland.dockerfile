FROM node:latest

RUN npm install -g pm2

COPY    ./microservices/banana-site /usr/src/app

WORKDIR /usr/src/app

EXPOSE 		8080

ENTRYPOINT ["pm2", "start", "server.js","--watch","--no-daemon"]
