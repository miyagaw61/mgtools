#!/bin/sh

hflg=0

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done
shift $(($OPTIND - 1))

if test $hflg -eq 1 ;then
	echo "Usage: rst"
	exit 0
fi

cp -a /mnt/bk/bin/* ~/bin/
cp -a /mnt/bk/ctf/* ~/ctf/
cp -a /mnt/bk/Desktop/* ~/Desktop/
cp -a /mnt/bk/Documents/* ~/Documents/
cp -a /mnt/bk/neosnippets/* ~/neosnippets/
cp -a /mnt/bk/peda/* ~/peda/
cp -a /mnt/bk/rc/* ~/rc/
cp -a /mnt/bk/tmp/* ~/tmp/


