FROM nginx:latest

VOLUME /var/cache/nginx

# Copy custom nginx config
COPY ./.docker/config/nginx.production.conf /etc/nginx/nginx.conf


# assets
COPY ./public 									/var/www/public/default

# using static files for testing
# COPY ./microservices/banana-site/public 	/var/www/public/banana-site
# COPY ./microservices/apple-site/src 			/var/www/public/apple-site

# testing keepalived with unicast
# RUN apt-get update
# RUN apt-get install -y keepalived

COPY ./.docker/config/keepalived.init.sysctl.conf /etc/init/sysctl.conf
# COPY ./.docker/config/keepalived.init.sysctl.conf /etc/init/keepalived.conf

COPY ./.docker/config/keepalived.sysctl.conf /etc/sysctl.conf
RUN chmod +rwx /etc/sysctl.conf

# RUN sysctl -p
#RUN sysctl -f /etc/sysctl.conf

COPY ./.docker/config/keepalived2.conf /etc/keepalived/keepalived.conf

# testing supervisor
# RUN apt-get install -y supervisor
EXPOSE 80 443 22

# ENTRYPOINT ["service","keepalived","start"]

# CMD sysctl -p && service keepalived start && ip addr show eth0 && nginx start

# Copy ssl cert
COPY ./.docker/config/nginx/nginx.crt /etc/nginx/ssl/server.crt
COPY ./.docker/config/nginx/nginx.key /etc/nginx/ssl/server.key

# Copy basic auth
# COPY ./.docker/config/nginx/passwords /conf/passwords

# basic encrypted username:password is admin:dockerland
RUN cd / && mkdir -p /conf && touch /conf/passwords && sh -c "echo -n 'admin:' >> /conf/passwords" && sh -c "openssl passwd dockerland >> /conf/passwords"

COPY ./.docker/config/nginx.supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
#ip addr sh eth0
#sysctl net.ipv4.ip_nonlocal_bind