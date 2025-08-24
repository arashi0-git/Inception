FROM nginx:alpine

RUN apk add --no-cache openssl

RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes -days 365 \
        -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=Student/CN=localhost" \
        -newkey rsa:2048 \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt

COPY conf/default.conf /etc/nginx/conf.d/default.conf
