FROM python:3
WORKDIR /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt
COPY . /usr/src/app
COPY docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh
CMD /usr/src/app/docker-entrypoint.sh
