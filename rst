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

rsync -auv /mnt/windows/bk/bin/         ~/bin/  
rsync -auv /mnt/windows/bk/ctf/         ~/ctf/  
rsync -auv /mnt/windows/bk/Desktop/     ~/Desktop/  
rsync -auv /mnt/windows/bk/Documents/   ~/Documents/  
rsync -auv /mnt/windows/bk/Downloads/   ~/Downloads/  
rsync -auv /mnt/windows/bk/neosnippets/ ~/neosnippets/  
rsync -auv /mnt/windows/bk/peda/        ~/peda/  
rsync -auv /mnt/windows/bk/rc/          ~/rc/  
rsync -auv /mnt/windows/bk/tmp/         ~/tmp/  
rsync -auv /mnt/windows/bk/rc/bashrc    ~/.bashrc
rsync -auv /mnt/windows/bk/rc/vimrc     /usr/share/vim/vimrc
