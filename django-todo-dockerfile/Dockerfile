FROM python:latest

WORKDIR /app
RUN git clone https://github.com/shacker/gtd.git
RUN pip install django django-todo django-extensions psycopg2-binary
RUN apt-get update && apt-get install nano

COPY conf/local.py /app/gtd/project/local.py

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/start.sh"]