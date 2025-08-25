FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    php8.2-dom \
    php8.2-mbstring \
    php8.2-opcache \
    php8.2-gd \
    php8.2-xml \
    mariadb-client \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 33 www-data || true && useradd -u 33 -g www-data -d /var/www -s /bin/bash www-data || true

RUN curl -L -o wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v2.8.1/wp-cli-2.8.1.phar && \
  chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
  curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
  tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
  rm /tmp/wordpress.tar.gz && \
  chown -R www-data:www-data /var/www/html

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]
CMD ["php-fpm8.2", "-F"]
