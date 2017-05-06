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

cp -ar /mnt/bk/bin/ ~/bin/
cp -ar /mnt/bk/ctf/ ~/ctf/
cp -ar /mnt/bk/Desktop/ ~/Desktop/
cp -ar /mnt/bk/Documents/ ~/Documents/
cp -ar /mnt/bk/neosnippets/ ~/neosnippets/
cp -ar /mnt/bk/peda/ ~/peda/
cp -ar /mnt/bk/rc/ ~/rc/
cp -ar /mnt/bk/tmp/ ~/tmp/


