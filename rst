#!/bin/sh

hflg=0

#if test $# -eq 0  = "False" ;then
#	hflg=1
#fi

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done
shift $(($OPTIND - 1))

if test $hflg -eq 1  = "False" ;then
	echo "Usage: rst"
	exit 0
fi

#if test "$(hashdiff /mnt/windows/bk/miyagawtools/ $HOME/miyagawtools/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/miyagawtools/ -> '$HOME'/miyagawtools/'
	rsync -auv /mnt/windows/bk/miyagawtools/*         $HOME/miyagawtools/
#fi


#if test "$(hashdiff /mnt/windows/bk/ctf/ $HOME/ctf/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/ctf/ -> '$HOME'/ctf/'
	rsync -auv /mnt/windows/bk/ctf/*         $HOME/ctf/
#fi


#if test "$(hashdiff /mnt/windows/bk/Desktop/ $HOME/Desktop/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/Desktop/ -> '$HOME'/Desktop/'
	rsync -auv /mnt/windows/bk/Desktop/*     $HOME/Desktop/
#fi


#if test "$(hashdiff /mnt/windows/bk/Documents/ $HOME/Documents/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/Documents/ -> '$HOME'/Documents/'
	rsync -auv /mnt/windows/bk/Documents/*   $HOME/Documents/
#fi


#if test "$(hashdiff /mnt/windows/bk/Downloads/ $HOME/Downloads/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/Downloads/ -> '$HOME'/Downloads/'
	rsync -auv /mnt/windows/bk/Downloads/*   $HOME/Downloads/
#fi


#if test "$(hashdiff /mnt/windows/bk/tmp/ $HOME/tmp/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/tmp/ -> '$HOME'/tmp/'
	rsync -auv /mnt/windows/bk/tmp/*         $HOME/tmp/
#fi


#if test "$(hashdiff /mnt/windows/bk/neosnippets/ $HOME/neosnippets/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/neosnippets/ -> '$HOME'/neosnippets/'
	rsync -auv /mnt/windows/bk/neosnippets/* $HOME/neosnippets/
#fi


#if test "$(hashdiff /mnt/windows/bk/peda/ $HOME/peda/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/peda/ -> '$HOME'/peda/'
	rsync -auv /mnt/windows/bk/peda/*        $HOME/peda/
#fi


#if test "$(hashdiff /mnt/windows/bk/rc/ $HOME/rc/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/rc/ -> '$HOME'/rc/'
	rsync -auv /mnt/windows/bk/rc/*          $HOME/rc/
#fi


#if test "$(diff -q $HOME/rc/bashrc $HOME/.bashrc)" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/rc/bashrc/ -> '$HOME'/.bashrc/'
	rsync -auv $HOME/rc/bashrc    $HOME/.bashrc
#fi


#if test "$(diff -q $HOME/rc/vimrc /usr/share/vim/vimrc)" ;then
	cecho -rfn '[+]'
	cecho -gf '/mnt/windows/bk/rc/vimrc/ -> /usr/share/vim/vimrc/'
	rsync -auv $HOME/rc/vimrc     /usr/share/vim/
#fi

