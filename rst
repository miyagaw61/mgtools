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

if test "$(diff -u /mnt/windows/bk/miyagawtools/ $HOME/miyagawtools/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/miyagawtools/ -> '$HOME'/miyagawtools/'
rsync -auv /mnt/windows/bk/miyagawtools/*         $HOME/miyagawtools/
fi


if test "$(diff -u /mnt/windows/bk/ctf/ $HOME/ctf/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/ctf/ -> '$HOME'/ctf/'
rsync -auv /mnt/windows/bk/ctf/*         $HOME/ctf/
fi


if test "$(diff -u /mnt/windows/bk/Desktop/ $HOME/Desktop/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Desktop/ -> '$HOME'/Desktop/'
rsync -auv /mnt/windows/bk/Desktop/*     $HOME/Desktop/
fi


if test "$(diff -u /mnt/windows/bk/Documents/ $HOME/Documents/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Documents/ -> '$HOME'/Documents/'
rsync -auv /mnt/windows/bk/Documents/*   $HOME/Documents/
fi


if test "$(diff -u /mnt/windows/bk/Downloads/ $HOME/Downloads/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Downloads/ -> '$HOME'/Downloads/'
rsync -auv /mnt/windows/bk/Downloads/*   $HOME/Downloads/
fi


if test "$(diff -u /mnt/windows/bk/tmp/ $HOME/tmp/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/tmp/ -> '$HOME'/tmp/'
rsync -auv /mnt/windows/bk/tmp/*         $HOME/tmp/
fi


if test "$(diff -u /mnt/windows/bk/neosnippets/ $HOME/neosnippets/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/neosnippets/ -> '$HOME'/neosnippets/'
rsync -auv /mnt/windows/bk/neosnippets/* $HOME/neosnippets/
fi


if test "$(diff -u /mnt/windows/bk/peda/ $HOME/peda/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/peda/ -> '$HOME'/peda/'
rsync -auv /mnt/windows/bk/peda/*        $HOME/peda/
fi


if test "$(diff -u /mnt/windows/bk/rc/ $HOME/rc/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/ -> '$HOME'/rc/'
rsync -auv /mnt/windows/bk/rc/*          $HOME/rc/
fi


if test "$(diff -u /mnt/windows/bk/rc/bashrc/ $HOME/.bashrc/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/bashrc/ -> '$HOME'/.bashrc/'
rsync -auv /mnt/windows/bk/rc/bashrc    $HOME/.bashrc
fi


if test "$(diff -u /mnt/windows/bk/rc/vimrc/ /usr/share/vim/vimrc/ | grep @@)" ;then
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/vimrc/ -> /usr/share/vim/vimrc/'
rsync -auv /mnt/windows/bk/rc/vimrc     /usr/share/vim/
fi

