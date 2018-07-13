#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

overlay=""
src="/src"
over="/over"
home="/home/build"

while [[ $# -gt 1 ]]
do
	case "$1" in
	-s) if [ -n "$1" ]; then src="$1"; fi ; shift ;;
	-o) overlay="true" ;;
	*) echo "Unknown option \"$1\"" 1>&2 ; exit 1 ;;
	esac
done

if ! id -u build 2>&1 > /dev/null
then
  useradd -m -s /bin/bash -d $home build
  chown -R build:build ${home}
fi

if [ -n "${overlay}" ]
then
	echo "Overlaying docker volume..."

	mkdir -p ${home}/src
	chown -R build:build ${home}

	mkdir ${over}
	umount ${over} || /bin/true
	mount -t tmpfs ${over} ${over}
	mkdir -p ${over}/upper ${over}/work

	umount ${home}/src || /bin/true
	mount -t overlay overlay -o lowerdir=${src},upperdir=${over}/upper,workdir=${over}/work ${home}/src
else
	echo "Linking docker volume..."
	if test -L ${home}/src
	then
		target=`readlink -f ${src}`
		if ["${target}" -ne "${home}/src"]
		then
			echo "${home}/src points to ${target}, but should point to ${src}"
		fi
	else
		ln -sf ${src} ${home}/src
	fi
fi
