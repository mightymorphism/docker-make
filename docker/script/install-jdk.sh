#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

apt-get update

# Install the full JDK
java_version=`/usr/local/bin/cfg-version java`
apt-get install -y ${java_version}-jdk-headless
