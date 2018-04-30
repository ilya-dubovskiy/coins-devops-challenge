#! /bin/bash -e

cd /app/gtd/
ls -la ./
pwd
python -V
python manage.py migrate &&
python manage.py runserver localhost:8080