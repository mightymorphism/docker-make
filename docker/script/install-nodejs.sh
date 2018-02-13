#! /bin/bash
# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

# Install nodejs
nodejs_version=`/usr/local/bin/cfg-version nodejs`
nodejs_package_name="node-v${nodejs_version}-linux-x64"
nodejs_package="${nodejs_package_name}.tar.gz"

cd /tmp

wget --no-verbose https://nodejs.org/dist/v${nodejs_version}/${nodejs_package}

tar -C /usr/local -xzpf ${nodejs_package}
rm -Rf /usr/local/nodejs
mv /usr/local/${nodejs_package_name} /usr/local/nodejs
chown -R root:root /usr/local/nodejs
echo 'export PATH=$PATH:/usr/local/nodejs/bin' >> /etc/profile.d/nodejs.sh

rm -f ${nodejs_package}
