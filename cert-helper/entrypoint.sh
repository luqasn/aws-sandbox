#!/bin/bash
set -eo pipefail
echo "Waiting for certificates to be generated"
while [ ! -f /mitmproxy/mitmproxy-ca-cert.pem ] || [ ! -f /caddy/pki/authorities/local/root.crt ]
do
  sleep 2
done

echo "Certificates found, generating..."

cp "/mitmproxy/mitmproxy-ca-cert.pem" /usr/local/share/ca-certificates/mitmproxy.crt
cp "/caddy/pki/authorities/local/root.crt" /usr/local/share/ca-certificates/caddy.crt

update-ca-certificates -f

rm -rf /tmp/certs/*
cp -L /etc/ssl/certs/* /tmp/certs/

ln -sf /tmp/certs/ca-certificates.crt /tmp/certs/ca-bundle.crt

# sleep a bit to make compose happy
sleep 30