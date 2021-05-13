#!/bin/bash
set -ex

wget https://github.com/nestybox/sysbox/releases/download/v0.3.0/sysbox-ce_0.3.0-0.ubuntu-focal_amd64.deb
shasum sysbox-ce_0.3.0-0.ubuntu-focal_amd64.deb
docker rm $(docker ps -a -q) -f
sudo apt-get install ./sysbox-ce_0.3.0-0.ubuntu-focal_amd64.deb -y
