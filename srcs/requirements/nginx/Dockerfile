FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y openssl nginx && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes -days 365 \
        -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=Student/CN=aryamamo.42.fr" \
        -newkey rsa:2048 \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt

COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
