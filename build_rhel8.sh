#!/usr/bin/env bash

echo 10.0.x brach

DEF_TAGS="10.0.9,10.0.8,10.0.7,10.0.6,10.0.5,10.0.4,10.0.3,10.0.2,10.0.1,10.0.0-GA"

BUILD_ARCH=x86_64
RC=XBRING
OS=RHEL8_x86_64
Z_RELEASE=LIBERTY
RELEASE=10.0.9
export RPM_BUILD_ROOT=/home/build/rpmbuild

export PKG_OS_TAG

./build.pl --ant-options -DskipTests=true \
    --git-default-tag=$DEF_TAGS --build-type=FOSS --build-release=$Z_RELEASE \
	--build-release-no=$RELEASE  \
	--build-type=FOSS \
	--build-release=$Z_RELEASE \
	--build-release-candidate=$RC \
	--build-thirdparty-server=files.zimbra.com \
	--build-arch=$BUILD_ARCH \
	--build-os=$OS \
	--no-interactive


