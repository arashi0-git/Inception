FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/nginx/sites-enabled/default /etc/nginx/conf.d/default.conf || true

RUN mkdir -p /etc/nginx/certs

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#         -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=Student/CN=aryamamo.42.fr" \
#         -addext "subjectAltName=DNS:aryamamo.42.fr" \
#         -keyout /etc/nginx/certs/server.key \
#         -out /etc/nginx/certs/server.crt && \
#     chmod 600 /etc/nginx/certs/server.key && chmod 644 /etc/nginx/certs/server.crt
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=Inception/CN=localhost" \
        -addext "subjectAltName=DNS:localhost,IP:127.0.0.1" \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt && \
    chmod 600 /etc/nginx/certs/server.key && \
    chmod 644 /etc/nginx/certs/server.crt

COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
