FROM alpine:latest

RUN apk add --no-cache php php-fpm php-mysqli php-json php-session php-curl php-dom php-mbstring php-opcache php-gd php-iconv php-xml php-tokenizer php-fileinfo php-exif nginx curl tar

RUN curl -O
https://raw.githubusercontent.com/wp-cli/wp-cli/v2.8.1/wp-cli.phar && \
  chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
  curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
  tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
  rm /tmp/wordpress.tar.gz

COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]
CMD ["php-fpm", "-F"]
