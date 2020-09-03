#!/bin/bash
set -ex

if [ "$1" != "/mitmproxy/mitmproxy-ca-cert.pem" ]; then
    exit 0
fi

echo "Updating cert bundle"

cp "$1" /usr/local/share/ca-certificates/mitmproxy.crt

update-ca-certificates -f
rm /etc/ssl/certs/mitmproxy.pem
cp "$1" /etc/ssl/certs/mitmproxy.pem
ln -sf /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-bundle.crt