#!/usr/bin/env bash

BUILD_ARCH=x86_64
RC=XBRING
RELEASE=9.0.1
OS=RHEL9_x86_64
PKG_OS_TAG=RHEL

export RPM_BUILD_ROOT=/home/build/rpmbuild

export PKG_OS_TAG

./build.pl --ant-options -DskipTests=true \
	--git-default-tag=9.0.0.p41,9.0.0.p40,9.0.0.p39,9.0.0.p38,9.0.0.p37,9.0.0.p36,9.0.0.p35,9.0.0.p34,9.0.0.p33,9.0.0.p32.1,9.0.0.p32,9.0.0.p31,9.0.0.p30,9.0.0.p29,9.0.0.p28,9.0.0.p27,9.0.0.p26,9.0.0.p25,9.0.0.p24.1,9.0.0.p24,9.0.0.p23,9.0.0.p22,9.0.0.p21,9.0.0.p20,9.0.0.p19,9.0.0.p18,9.0.0.p17,9.0.0.p16,9.0.0.p15,9.0.0.p14,9.0.0.p13,9.0.0.p12,9.0.0.p11,9.0.0.p10,9.0.0.p9,9.0.0.p8,9.0.0.p7,9.0.0.p6.1,9.0.0.p6,9.0.0.p5,9.0.0.p4,9.0.0.p3,9.0.0.p2,9.0.0.p1,9.0.0 \
	--build-release-no=$RELEASE --build-type=FOSS --build-release=KEPLER --build-release-candidate=$RC \
	--build-thirdparty-server=files.zimbra.com \
	--build-arch=$BUILD_ARCH \
	--build-os=$OS \
	--no-interactive


