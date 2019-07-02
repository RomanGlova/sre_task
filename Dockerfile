FROM python:3.7.3-alpine

COPY main.py prerequisites.txt /opt/app/

RUN pip3 install -r /opt/app/prerequisites.txt

ENTRYPOINT ['python /opt/app/main.py']