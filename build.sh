#!/usr/bin/env bash

FILE=/etc/yum.repos.d/CentOS-AppStream.repo
cat > $FILE <<- EOM
[AppStream]
name=CentOS-$releasever - AppStream
#mirrorlist=http://#mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=AppStream&infra=$infra
baseurl=http://vault.centos.org/$contentdir/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

FILE=/etc/yum.repos.d/CentOS-Base.repo
cat > $FILE <<- EOM
[BaseOS]
name=CentOS-$releasever - Base
#mirrorlist=http://#mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=BaseOS&infra=$infra
baseurl=http://vault.centos.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

FILE=/etc/yum.repos.d/CentOS-Extras.repo
cat > $FILE <<- EOM
[extras]
name=CentOS-$releasever - Extras
#mirrorlist=http://#mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
baseurl=http://vault.centos.org/$contentdir/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

yum install -y rsync vim

RC=XBRING
NUM=99000

./build.pl --ant-options -DskipTests=true \
	--git-default-tag=9.0.0.p41,9.0.0.p40,9.0.0.p39,9.0.0.p38,9.0.0.p37,9.0.0.p36,9.0.0.p35,9.0.0.p34,9.0.0.p33,9.0.0.p32.1,9.0.0.p32,9.0.0.p31,9.0.0.p30,9.0.0.p29,9.0.0.p28,9.0.0.p27,9.0.0.p26,9.0.0.p25,9.0.0.p24.1,9.0.0.p24,9.0.0.p23,9.0.0.p22,9.0.0.p21,9.0.0.p20,9.0.0.p19,9.0.0.p18,9.0.0.p17,9.0.0.p16,9.0.0.p15,9.0.0.p14,9.0.0.p13,9.0.0.p12,9.0.0.p11,9.0.0.p10,9.0.0.p9,9.0.0.p8,9.0.0.p7,9.0.0.p6.1,9.0.0.p6,9.0.0.p5,9.0.0.p4,9.0.0.p3,9.0.0.p2,9.0.0.p1,9.0.0 \
	--build-release-no=9.0.0 --build-type=FOSS --build-release=KEPLER --build-release-candidate=$RC \
	--build-thirdparty-server=files.zimbra.com --no-interactive \
	--build-no=$NUM

