FROM		python:latest

RUN			pip install flower

EXPOSE 		5555

ENTRYPOINT ["flower", "--port=5555", "--broker=amqp://guest:guest@rabbit:5672//", "--broker_api=http://guest:guest@rabbit:15672/api/"]