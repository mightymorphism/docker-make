#! /bin/bash
# Copyright (c) 2018 Trough Creek Holdings, LLC.  All Rights Reserved

set -eo pipefail

waitfor=""
sleep_time=1
environment="${RAILS_ENV}"

while [[ $# -gt 1 ]]
do
	case "$1" in
	-e)
		if [ -z "$2" ]
		then
		  echo "Missing environment" 1>&2
		  exit 1
		fi
	        environment="$2"
		shift ;;

	-w)
		if [ -z "$2" ]
		then
		  echo "Missing waitfor host" 1>&2
		  exit 1
		fi
	        waitfor="$2"
		shift ;;
	-s)
		if [ -z "$2" ]
		then
		  echo "Missing sleep time" 1>&2
		  exit 1
		fi
	        sleep_time="$2"
		shift ;;

	--) shift ; break ;;

	*) echo "Unknown option \"$1\"" 1>&2 ; exit 1 ;;
	esac

	shift
done

if [ "${environment}" = "production" ]
then
  for f in /home/api/bootstrap/*
  do
    name=`basename "$f"`
    runas -u api ln -sf "$f" "/home/api/config/${name}"
  done
fi

if [ -n "${waitfor}" ]
then
	/usr/bin/waitfor -t 90 "${waitfor}"
fi

# BOTCH: don't try to pass anything too fancy through
cmd="$1"
shift
args="$@"

runas -u api bash -c "(. /home/api/vendor/virtualenv/bin/activate ; $cmd $args)" || sleep $sleep_time
