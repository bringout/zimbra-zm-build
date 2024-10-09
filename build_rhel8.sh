#!/usr/bin/env bash

echo 10.1.x brach

sudo bash install_rsync.sh

DEF_TAGS="10.1.2,10.1.1,10.1.0"

BUILD_ARCH=x86_64
RC=XBRING
OS=RHEL8_64
Z_RELEASE=DAFFODIL
RELEASE=10.1.2
export RPM_BUILD_ROOT=/home/build/rpmbuild

export PKG_OS_TAG

./build.pl --ant-options -DskipTests=true \
    --git-default-tag=$DEF_TAGS --build-type=FOSS \
	--build-release=$Z_RELEASE \
	--build-release-no=$RELEASE  \
	--build-type=FOSS \
	--build-release=$Z_RELEASE \
	--build-release-candidate=$RC \
	--build-thirdparty-server=files.zimbra.com \
	--build-arch=$BUILD_ARCH \
	--build-os=$OS \
	--no-interactive


