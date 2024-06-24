FROM php:8.2-fpm-alpine

RUN apk add --no-cache \
    libpq-dev \
    nodejs \
    npm

# RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pgsql pdo pdo_pgsql

RUN apk update && apk add --no-cache supervisor

RUN mkdir -p "/etc/supervisor/logs"

# COPY /supervisor/supervisord.conf /etc/supervisor/supervisord.conf

COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]



# FROM php:8.2-fpm-alpine

# LABEL author="redditsaved"

# ENV APP_ROOT=var/www/html QUEUE_DRIVER=database NUM_PROCS=4 OPTIONS=

# ADD supervisord.conf /etc/

# RUN docker-php-ext-install \
#     && docker-php-ext-install bcmath \
#     && apt-get update \ 
#     && apt-get install -y --no-install-recommends supervisor

# CMD ["supervisord", "-c", "/etc/supervisord.conf"]