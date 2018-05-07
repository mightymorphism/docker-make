#! /bin/bash
# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

# Install basic build dependencies that are required only at build time
apt-get install -y build-essential gdb git jq
apt-get install -y libqt5webkit5-dev qt5-default
