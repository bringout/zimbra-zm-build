#!/bin/bash
# 
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2005, 2007, 2009, 2010, 2013 Zimbra, Inc.
# 
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software Foundation,
# version 2 of the License.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.
# ***** END LICENSE BLOCK *****
# 

verifyExists() {
	EXISTS=0
	NM=`/usr/bin/nifind /$1/$2`
	if [ "x$NM" != "x" ]; then
		EXISTS=1
	fi
}

verifyAvailable() {
	verifyExists $1 $2
	if [ $EXISTS = 1 ]; then
		echo "$1 $2 already exists!"
		exit 1
	fi
}

getNextGID() {
	GID=`/usr/bin/nireport / /groups gid | sort -n | tail -1`
	GID=`expr $GID + 1`
}

getGIDByName() {
	IDS=`/usr/bin/niutil -read / /groups/$1 | egrep '^gid:' | sed -e 's/gid: //'`
	if [ "x$IDS" != "x" ]; then
		GID=$IDS
	fi
}

getNextUID() {
	NUID=`/usr/bin/nireport / /users uid | sort -n | tail -1`
	NUID=`expr $NUID + 1`
}

while [ $# != 0 ]; do
	case "$1" in 
		-d)
			shift
			homedir=$1
		;;
		-g)
			shift
			maingroup=$1
		;;
		-G)
			shift
			auxgroups=$1
		;;
		*)
			name=$1
		;;
	esac
	shift

done

if [ "x$name" = "x" ]; then
	echo "You must specify a user name!"
	exit 1
fi

if [ "x$maingroup" = "x" ]; then
	maingroup=$name
fi

auxgroups=`echo $auxgroups | sed -e 's/,/ /g'`

verifyAvailable "users" $name

for g in $auxgroups; do
	verifyExists groups $g
	if [ $EXISTS = 0 ]; then
		echo "Auxiliary group $g not found!"
		exit 1
	else
		/usr/bin/niutil -mergeprop / /groups/$g users $name
	fi
done

verifyExists groups $maingroup
if [ $EXISTS = 1 ]; then
	getGIDByName $maingroup
	creategroup=0
else
	getNextGID
	creategroup=1
fi
maingid=$GID
getNextUID 
mainuid=$NUID

echo "Creating $name with UID $mainuid, GID $maingid"
if [ $creategroup = 1 ]; then
	/usr/bin/niutil -create / /groups/$maingroup
	/usr/bin/niutil -createprop / /groups/$maingroup gid $maingid
fi
/usr/bin/niutil -mergeprop / /groups/$maingroup users $name

niutil -create / /users/$name
niutil -createprop / /users/$name realname $name
niutil -createprop / /users/$name uid $mainuid
niutil -createprop / /users/$name gid ${maingid}
niutil -createprop / /users/$name shell /bin/bash

if [ x$homedir != "x" ]; then
	niutil -createprop / /users/$name home $homedir
fi

exit 0
