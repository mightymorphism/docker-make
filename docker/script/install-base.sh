#! /bin/bash
# Copyright (c) 2017, 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

if [ -f /root/package-maintainer.asc ]
then
	apt-key add /root/package-maintainer.asc
fi

rm -f /etc/apt/apt.conf.d/recommends
echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf.d/recommends
echo 'APT::Install-Suggests "false";' >> /etc/apt/apt.conf.d/recommends

apt-get update -y
apt-get upgrade -y

# Install basic shell utilities
apt-get install -y file wget
apt-get install -y vim-tiny less
apt-get install -y dnsutils telnet
apt-get install -y libpq-dev postgresql-client
apt-get install -y ca-certificates
apt-get install -y locales
apt-get install -y runas

apt-get clean

localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
update-locale LANG=en_US.UTF-8

export LOCALE="en_US.utf8"
echo 'export LOCALE=en_US.utf8' >> /etc/profile.d/locale.sh
echo 'export LANG=en_US.utf8' >> /etc/profile.d/locale.sh

# Update the set of installed CA certs
/usr/sbin/update-ca-certificates
