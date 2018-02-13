#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

# Install golang
golang_version=`/usr/local/bin/cfg-version golang`

cd /tmp
wget --no-verbose https://storage.googleapis.com/golang/go${golang_version}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${golang_version}.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile.d/golang.sh

rm -f /tmp/go${golang_version}.linux-amd64.tar.gz
