#!/bin/sh

hflg=0

#if test $# -eq 0 ;then
#	hflg=1
#fi

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

rsync -rlpgoDuv /mnt/windows/bk/bin/         bin/  
rsync -rlpgoDuv /mnt/windows/bk/ctf/         ctf/  
rsync -rlpgoDuv /mnt/windows/bk/Desktop/     Desktop/  
rsync -rlpgoDuv /mnt/windows/bk/Documents/   Documents/  
rsync -rlpgoDuv /mnt/windows/bk/Downloads/   Downloads/  
rsync -rlpgoDuv /mnt/windows/bk/neosnippets/ neosnippets/  
rsync -rlpgoDuv /mnt/windows/bk/peda/        peda/  
rsync -rlpgoDuv /mnt/windows/bk/rc/          rc/  
rsync -rlpgoDuv /mnt/windows/bk/tmp/         tmp/  
