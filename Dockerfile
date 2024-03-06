FROM python:3
WORKDIR /usr/local
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && mkdir static 
COPY . /usr/local
COPY docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh
CMD /usr/local/docker-entrypoint.sh
