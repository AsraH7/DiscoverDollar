# stage1
FROM php:7.1.23-apache
WORKDIR /
COPY . /var/www/html
RUN echo "serverName localhost:80" >> /etc/apache2/apache2.conf
RUN docker-php-ext-install pdo_mysql
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


# stage2
FROM wordpress:apache
WORKDIR /usr/src/wordpress
RUN set -eux; \
        find /etc/apache2 -name '*.conf' -type f -exec sed -ri -e "s!/var/www/html!$PWD!g" -e "s!Directory /var/www/!Directory $PWD!g" '{}' +; \
        cp -s wp-config-docker.php wp-config.php
CMD echo "this is wordpress"

