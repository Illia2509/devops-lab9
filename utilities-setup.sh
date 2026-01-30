#!/bin/bash
set -xe

apt update -y

apt install -y docker.io

systemctl stop docker.socket
systemctl disable docker.socket

mkdir -p /etc/systemd/system/docker.service.d

cat <<SCRIPT > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375
SCRIPT

systemctl daemon-reload
systemctl enable --now docker

usermod -aG docker ubuntu