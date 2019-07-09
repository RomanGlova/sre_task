FROM python:3.7.3-alpine

COPY src/main.py src/prerequisites.txt /opt/app/

RUN pip3 install -r /opt/app/prerequisites.txt && \
    chmod +x /opt/app/main.py

WORKDIR "/opt/app"

CMD ["python", "/opt/app/main.py"]