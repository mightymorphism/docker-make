#!/bin/bash
# Copyright (c) 2017 Trough Creek Holdings, LLC.  All Rights Reserved

set -e

while [[ $# -gt 1 ]]
do
	case "$1" in
	-o) overlay="true"; shift ;;
	*) echo "Unknown option \"$1\"" 1>&2 ; exit 1 ;;
	esac
done

INVOKE_DIR=$(pwd)
PACKAGE_DIR=$(mktemp -d)
trap "{ cd ${INVOKE_DIR}; rm -Rf $PACKAGE_DIR; }" EXIT

test -n "${BUILD_ROOT}" || (echo "Missing BUILD_ROOT" && exit 1)
package_name="${PACKAGE_NAME}-${PACKAGE_VERSION}"

cd ${PACKAGE_DIR}

echo "BUILD_ROOT: ${BUILD_ROOT}"
echo "RELEASE: ${RELEASE}"
echo "RELEASE_DATE: ${RELEASE_DATE}"

echo "Version: ${PACKAGE_VERSION}"

mkdir -p ${package_name} && cd ${package_name}
mkdir -p DEBIAN \
  usr/bin

cp ${BUILD_ROOT}/bin/${PACKAGE_NAME}  usr/bin/

# Debian packaging files
for f in conffiles control postinst prerm
do
	if [ -f ${BUILD_ROOT}/dist/ubuntu/spec/$f ]
	then
		cp ${BUILD_ROOT}/dist/ubuntu/spec/$f DEBIAN/$f
	fi
done

# Replace package version placeholder with the version value
sed -i -r -e "s/Version: VERSION/Version: ${PACKAGE_VERSION}/g" DEBIAN/control

# deb building command =========================================================
cd ${PACKAGE_DIR}
dpkg-deb --build ${package_name}/

# store packages ===============================================================
cp ${package_name}.deb ${BUILD_ROOT}/dist/ubuntu/deb
