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

cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/miyagawtools/ -> '$HOME'/miyagawtools/'
rsync -auv /mnt/windows/bk/miyagawtools/*         $HOME/miyagawtools/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/ctf/ -> '$HOME'/ctf/'
rsync -auv /mnt/windows/bk/ctf/*         $HOME/ctf/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Desktop/ -> '$HOME'/Desktop/'
rsync -auv /mnt/windows/bk/Desktop/*     $HOME/Desktop/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Documents/ -> '$HOME'/Documents/'
rsync -auv /mnt/windows/bk/Documents/*   $HOME/Documents/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/Downloads/ -> '$HOME'/Downloads/'
rsync -auv /mnt/windows/bk/Downloads/*   $HOME/Downloads/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/tmp/ -> '$HOME'/tmp/'
rsync -auv /mnt/windows/bk/tmp/*         $HOME/tmp/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/neosnippets/ -> '$HOME'/neosnippets/'
rsync -auv /mnt/windows/bk/neosnippets/* $HOME/neosnippets/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/peda/ -> '$HOME'/peda/'
rsync -auv /mnt/windows/bk/peda/*        $HOME/peda/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/ -> '$HOME'/rc/'
rsync -auv /mnt/windows/bk/rc/*          $HOME/rc/
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/bashrc/ -> '$HOME'/.bashrc/'
rsync -auv /mnt/windows/bk/rc/bashrc    $HOME/.bashrc
cecho -rfn '[+]'
cecho -gf '/mnt/windows/bk/rc/vimrc/ -> /usr/share/vim/vimrc/'
rsync -auv /mnt/windows/bk/rc/vimrc     /usr/share/vim/
