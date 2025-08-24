FROM debian:bullseye

RUN apt update \
  && apt install -y mariadb-server

COPY tools/start.sh /usr/local/bin/start.sh
COPY init.sql /docker-entrypoint-initdb.d/init.sql

RUN chmod +x /usr/local/bin/start.sh && sed -i 's/\r$//' /usr/local/bin/start.sh

VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["bin/sh", "/usr/local/bin/start.sh"]
