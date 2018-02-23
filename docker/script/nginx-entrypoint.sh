#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

upstream="${NGINX_UPSTREAM:-${NGINX_VHOSTNAME}}"
hostname="${NGINX_HOSTNAME}"
vhostname="${NGINX_VHOSTNAME}"

erb upstream_name="${upstream}" server_name="${hostname}" vhost_name="${vhostname}" /root/nginx-site.erb > /etc/nginx/sites-available/${vhostname}
ln -sf /etc/nginx/sites-available/${vhostname} /etc/nginx/sites-enabled/${vhostname}

cp /etc/ssl/private/*.crt /usr/local/share/ca-certificates
update-ca-certificates

# Run nginx in the foreground to placate the Docker monster
nginx -g 'daemon off;'
