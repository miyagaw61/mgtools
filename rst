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

rsync -urlpgov /mnt/windows/bk/bin/         bin/  
rsync -urlpgov /mnt/windows/bk/ctf/         ctf/  
rsync -urlpgov /mnt/windows/bk/Desktop/     Desktop/  
rsync -urlpgov /mnt/windows/bk/Documents/   Documents/  
rsync -urlpgov /mnt/windows/bk/Downloads/   Downloads/  
rsync -urlpgov /mnt/windows/bk/neosnippets/ neosnippets/  
rsync -urlpgov /mnt/windows/bk/peda/        peda/  
rsync -urlpgov /mnt/windows/bk/rc/          rc/  
rsync -urlpgov /mnt/windows/bk/tmp/         tmp/  
