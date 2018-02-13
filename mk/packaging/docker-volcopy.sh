#! /bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

src="/src"
overlay=""
pkgdir="dist/ubuntu/deb"

while [[ $# -gt 1 ]]
do
	case "$1" in
	-s) if [ -n "$1" ]; then src="$1"; fi ; shift ;;
	-o) overlay="true" ;;
	*) echo "Unknown option \"$1\"" 1>&2 ; exit 1 ;;
	esac
done

test -n "${BUILD_ROOT}" || (echo "Missing BUILD_ROOT" && exit 1)

cp ${BUILD_ROOT}/${pkgdir}/${PACKAGE_NAME}-${PACKAGE_VERSION}.deb ${src}/${pkgdir}
