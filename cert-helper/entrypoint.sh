#!/bin/bash
set -eo pipefail

test -f "/mitmproxy/mitmproxy-ca-cert.pem" && ./update.sh "/mitmproxy/mitmproxy-ca-cert.pem"

exec "$@"