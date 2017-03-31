FROM ubuntu:latest

VOLUME /var/cache/nginx-0

# testing static assets
COPY ./public /var/www/public

# keepalived with unicast
RUN apt-get update
RUN apt-get install -y nginx keepalived

# Copy custom nginx config
COPY ./.docker/config/nginx.production.conf /etc/nginx/nginx.conf


COPY ./.docker/config/keepalived.init.sysctl.conf /etc/init/sysctl.conf

# keepalived might be search all *.conf?
COPY ./.docker/config/keepalived.init.sysctl.conf /etc/init/keepalived.conf

COPY ./.docker/config/keepalived.sysctl.conf /etc/sysctl.conf
RUN chmod +rw /etc/sysctl.conf

# another path???
COPY ./.docker/config/keepalived.sysctl.conf /usr/local/etc/keepalived/keepalived.conf
RUN chmod +rw /usr/local/etc/keepalived/keepalived.conf

# RUN sysctl -p
#RUN sysctl -f /etc/sysctl.conf

#172.19.0.200
COPY ./.docker/config/keepalived1.conf /etc/keepalived/keepalived.conf

RUN apt-get install -y supervisor
EXPOSE 80 443 22

# ENTRYPOINT ["service","keepalived","start"]

CMD sysctl -p && service keepalived start && ip addr show eth0 && nginx -g 'daemon off;' 

# COPY ./.docker/config/nginx.supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# ENTRYPOINT ["nginx"]
# CMD ["-g", "daemon off;"]
#ip addr sh eth0
#sysctl net.ipv4.ip_nonlocal_bind