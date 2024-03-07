FROM python:3
WORKDIR /usr/src/app
COPY . ./
RUN mkdir static
COPY docker-entrypoint.sh ./
COPY django_tutorial/settings.bak django_tutorial/settings.py
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient
RUN chmod +x docker-entrypoint.sh
ENV ALLOWED_HOSTS=*
ENV HOST=mariadb
ENV USUARIO=django
ENV CONTRA=django
ENV BASE_DATOS=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
CMD /usr/src/app/docker-entrypoint.sh
