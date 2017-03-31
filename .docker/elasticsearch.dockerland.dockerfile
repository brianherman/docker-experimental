FROM 	elasticsearch:latest

EXPOSE	9200 9300

ENV 	LOGSPOUT=ignore

ADD 	./.docker/config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml