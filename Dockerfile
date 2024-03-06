FROM python:3
WORKDIR /usr/src/app
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && mkdir static 
COPY . /usr/src/app
COPY docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh
CMD /usr/src/app/docker-entrypoint.sh
