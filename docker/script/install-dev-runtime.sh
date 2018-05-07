#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

# Install basic build dependencies that are also required at runtime
apt-get install -y curl
apt-get install -y zlib1g-dev libssl-dev libreadline-dev
apt-get install -y libyaml-dev libyaml-cpp-dev libxml2-dev libxslt-dev
apt-get install -y libarchive-dev libgdbm-dev
