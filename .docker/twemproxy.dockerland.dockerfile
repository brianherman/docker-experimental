# TODO-MAK: alpine variation

FROM ubuntu:latest

ADD ./.docker/config/twemproxy.nutcracker.production.yml /conf/nutcracker.yml
ADD ./.docker/config/twemproxy.supervisord.production.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:twemproxy/stable
RUN apt-get update

RUN apt-get install -y supervisor
RUN apt-get install -y twemproxy

RUN apt-get install -y ruby rubygems build-essential automake 
RUN gem install nutcracker-web

EXPOSE 9292

# run nutcracker-web (also runs twemproxy).
ENTRYPOINT ["nutcracker-web","--config","/conf/nutcracker.yml","--launch"]