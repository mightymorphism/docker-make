#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

apt-get install -y nginx

mkdir -p /home/nginx/nginx
mv /root/nginx-500.html /var/www/html/500.html
mv /root/nginx.conf /etc/nginx
mv /root/nginx-entrypoint.sh /sbin
