#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

apt-get -y update

# Install basic build dependencies
apt-get install -y build-essential gdb curl git
apt-get install -y zlib1g-dev libssl-dev libreadline-dev
apt-get install -y libyaml-dev libxml2-dev libxslt-dev

apt-get clean
