#!/bin/bash
echo "Did you configure the Digital Ocean token in traefik.service?"
echo "Did you configure ACME email address in traefik.toml?"
read

set -eux

wget "https://github.com/containous/traefik/releases/download/v2.0.1/traefik_v2.0.1_linux_amd64.tar.gz"
tar -zxvf "traefik_v2.0.1_linux_amd64.tar.gz"
sudo mv traefik /usr/local/bin/traefik
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/traefik

useradd --home-dir /var/lib/traefik
sudo mkdir /etc/traefik
sudo mkdir /var/lib/traefik
sudo cp /etc/traefik/traefik.toml /etc/traefik/

sudo chown -R traefik:traefik /etc/traefik /var/lib/traefik
sudo cp etc/systemd/system/traefik.service /etc/systemd/system/

sudo systemctl start traefik
