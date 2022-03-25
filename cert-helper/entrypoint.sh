#!/bin/bash
set -eo pipefail
echo "Waiting for 5 seconds for certificates to be generated"
sleep 5

cp "/mitmproxy/mitmproxy-ca-cert.pem" /usr/local/share/ca-certificates/mitmproxy.crt
cp "/caddy/pki/authorities/local/root.crt" /usr/local/share/ca-certificates/caddy.crt

update-ca-certificates -f

rm -f /tmp/certs/*
cp -L /etc/ssl/certs/* /tmp/certs/

ln -sf /tmp/certs/ca-certificates.crt /tmp/certs/ca-bundle.crt