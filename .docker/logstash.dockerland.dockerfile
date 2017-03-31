FROM 	logstash:latest

EXPOSE	500 5000/udp

ENV 	LOGSPOUT=ignore

ADD 	./.docker/config/logstash.conf /conf/logstash.conf

CMD 	["-f", "/conf/logstash.conf"]