
FROM alpine:3.4

ADD ./.docker/config/configure-cluster.sh ./
RUN chmod +rx ./configure-cluster.sh

RUN apk add --no-cache bash

CMD ["bash","./configure-cluster.sh"]