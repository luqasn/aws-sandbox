#!/bin/bash
docker compose cp api-gateway:/data/caddy/pki/authorities/local/root.crt caddy.crt
# for now, only macOS support, sorry! PRs welcome :)
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" caddy.crt