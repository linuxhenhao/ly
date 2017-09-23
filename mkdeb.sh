#!/bin/bash
VERSION=0.1.0
LY_DIR=./ly

function GetArch()
{
	if [ $(uname -m) == "x86_64" ];then
		echo "amd64"
	else
		echo "i386"
	fi
}

if [ "x$ARCH" == "x" ];then
	ARCH=$( GetArch )
fi

echo $ARCH

function DirCheck()
{
	if [ ! -d $1 ];then
		mkdir -p $1
	fi
}

DirCheck ${LY_DIR}/DEBIAN

cat >./${LY_DIR}/DEBIAN/control<<EOF
Package: ly
Version: $VERSION
Architecture: $ARCH
Depends: libc6
Maintainer: huangyu<diwang90@gmail.com>
Description: ly display manager forked from cylgom/ly
EOF

make
make install DESTDIR=./ly
dpkg -b ${LY_DIR}
