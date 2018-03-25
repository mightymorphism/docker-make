#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

root="/home/api"

pip3 install --upgrade --user wheel virtualenv

if [ -f $root/vendor/virtualenv/bin/activate ]
then
	sed -E -e "s;VIRTUAL_ENV=.*;VIRTUAL_ENV=$root/vendor/virtualenv;g" -i $root/vendor/virtualenv/bin/activate
fi

#pip3 install --upgrade wheel virtualenv
virtualenv -p `which python3` $root/vendor/virtualenv

. $root/vendor/virtualenv/bin/activate

pip3 install --upgrade -r requirements.txt
virtualenv -p python3 --relocatable $root/vendor/virtualenv
