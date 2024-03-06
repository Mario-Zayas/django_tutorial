FROM python:3
WORKDIR /usr/src/app
RUN git clone hwttps://github.com/Mario-Zayas/django_tutorial.git ./
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir static
COPY docker-entrypoint.sh ./
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
