FROM nginx:latest

VOLUME /var/cache/nginx

# Copy custom nginx config
COPY ./.docker/config/nginx-test.production.conf /etc/nginx/nginx.conf

# testing static assets
COPY ./public /var/www/public

EXPOSE 80 443 22

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
#ip addr sh eth0