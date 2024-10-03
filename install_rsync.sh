#!/usr/bin/env bash

FILE=/etc/yum.repos.d/CentOS-AppStream.repo
cat > $FILE <<- EOM
[AppStream]
name=CentOS-$releasever - AppStream
#mirrorlist=http://#mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=AppStream&infra=\$infra
baseurl=http://vault.centos.org/\$contentdir/\$releasever/AppStream/\$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

FILE=/etc/yum.repos.d/CentOS-Base.repo
cat > $FILE <<- EOM
[BaseOS]
name=CentOS-$releasever - Base
#mirrorlist=http://#mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=BaseOS&infra=\$infra
baseurl=http://vault.centos.org/\$contentdir/\$releasever/BaseOS/\$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

FILE=/etc/yum.repos.d/CentOS-Extras.repo
cat > $FILE <<- EOM
[Extras]
name=CentOS-$releasever - Extras
#mirrorlist=http://#mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=extras&infra=\$infra
baseurl=http://vault.centos.org/\$contentdir/\$releasever/extras/\$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOM

yum update -y
yum install -y rsync vim

rsync --version
