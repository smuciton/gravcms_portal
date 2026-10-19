#!/bin/sh
set -e

SSL_DIR=/etc/apache2/ssl
mkdir -p "$SSL_DIR"

if [ -s /certs/cert.pem ] && [ -s /certs/key.pem ]; then
    cp /certs/cert.pem "$SSL_DIR/cert.pem"
    cp /certs/key.pem "$SSL_DIR/key.pem"
    echo "SSL: using certificate from /certs"
elif [ ! -s "$SSL_DIR/cert.pem" ]; then
    # Fallback so HTTPS works out of the box (browsers will warn)
    openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
        -subj "/CN=${SSL_CN:-localhost}" \
        -keyout "$SSL_DIR/key.pem" -out "$SSL_DIR/cert.pem" 2>/dev/null
    echo "SSL: no certificate in /certs, generated self-signed one"
fi
chmod 600 "$SSL_DIR/key.pem"

exec docker-php-entrypoint "$@"
