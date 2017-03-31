FROM	celery:latest

COPY    ./microservices/celery /home/user

ENTRYPOINT ["celery", "-A", "tasks", "worker", "--loglevel=info"]