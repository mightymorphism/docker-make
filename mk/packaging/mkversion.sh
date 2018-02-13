#! /bin/sh
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

while [[ $# -gt 1 ]]
do
	case "$1" in
	-r) BUILD_ROOT="$1"; shift ;;
	-p) PACKAGE_REVISION="$1"; shift ;;
	*) echo "Unknown option \"$1\"" 1>&2 ; exit 1 ;;
	esac
done

if [ -z "${BUILD_ROOT}" ]
then
	echo "Missing BUILD_ROOT" 1>&2
	exit 1
fi

if [ -z "${PACKAGE_REVISION}" ]
then
	echo "Missing PACKAGE_REVISION" 1>&2
	exit 1
fi

if [ -z "$1" ]
then
	echo "Missing location for version file" 1>&2
	exit 1
fi

GIT_REV=`git rev-parse HEAD`
DATE=`git show -s --format=%ci $GIT_REV`

TEMP=$(mktemp "${TMPDIR:-/tmp/}$(basename 0).XXXXXXXXXXXX")
trap "{ rm -f $TEMP; }" EXIT

cat > $TEMP <<- EOM
// Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved
package main

const BuildRelease = "$PACKAGE_REVISION"
const BuildRevision = "$GIT_REV"
const BuildDate = "$DATE"
EOM

cmp --silent "$1/version.go" $TEMP || mv $TEMP "$1/version.go"
