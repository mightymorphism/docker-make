#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

if [ "${RAILS_ENV}" = "production" ]
then
  for f in /home/api/bootstrap/*
  do
    name=`basename "$f"`
    runas -u api ln -sf "$f" "/home/api/config/${name}"
  done
fi

exec runas -u api bundle exec "$@"
