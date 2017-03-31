# alpine linux with ruby installed
FROM ruby:2-alpine

# redis dependencies
RUN apk add --no-cache tcl curl tar make gcc musl-dev linux-headers bash
RUN wget http://download.redis.io/releases/redis-3.2.4.tar.gz
RUN tar xzf redis-3.2.4.tar.gz

# working directory
WORKDIR redis-3.2.4

# install redis
RUN make
RUN make install

# install ruby redis client
RUN gem install redis

# use the cluster script
ADD ./.docker/config/configure-cluster.sh ./
# RUN chmod +rx ./configure-cluster.sh
RUN ls -la

# run the cluster script
CMD ["bash","./configure-cluster.sh"]