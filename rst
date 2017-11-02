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

if test $hflg -eq 1 ;then
	echo "Usage: rst"
	exit 0
fi

if test $# -eq 1 ;then
	dstPath=$1
elif test $# -eq 0 ;then
	dstPath="/mnt/windows/bk"
fi

#if test "$(hashdiff ${dstPath}/mgtools/ $HOME/Documents/git/mgtools/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/mgtools/ -> '$HOME'/mgtools/'
	rsync -auv ${dstPath}/mgtools/*         $HOME/Documents/git/mgtools/
#fi


#if test "$(hashdiff ${dstPath}/ctf/ $HOME/ctf/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/ctf/ -> '$HOME'/ctf/'
	rsync -auv ${dstPath}/ctf/*         $HOME/ctf/
#fi


#if test "$(hashdiff ${dstPath}/Desktop/ $HOME/Desktop/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/Desktop/ -> '$HOME'/Desktop/'
	rsync -auv ${dstPath}/Desktop/*     $HOME/Desktop/
#fi


#if test "$(hashdiff ${dstPath}/Documents/ $HOME/Documents/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/Documents/ -> '$HOME'/Documents/'
	rsync -auv ${dstPath}/Documents/*   $HOME/Documents/
#fi


#if test "$(hashdiff ${dstPath}/Downloads/ $HOME/Downloads/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/Downloads/ -> '$HOME'/Downloads/'
	rsync -auv ${dstPath}/Downloads/*   $HOME/Downloads/
#fi


#if test "$(hashdiff ${dstPath}/tmp/ $HOME/tmp/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/tmp/ -> '$HOME'/tmp/'
	rsync -auv ${dstPath}/tmp/*         $HOME/tmp/
#fi


#if test "$(hashdiff ${dstPath}/neosnippets/ $HOME/neosnippets/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/neosnippets/ -> '$HOME'/neosnippets/'
	rsync -auv ${dstPath}/neosnippets/* $HOME/neosnippets/
#fi


#if test "$(hashdiff ${dstPath}/peda/ $HOME/peda/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/peda/ -> '$HOME'/peda/'
	rsync -auv ${dstPath}/peda/*        $HOME/peda/
#fi


#if test "$(hashdiff ${dstPath}/rc/ $HOME/rc/)"  = "False" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/rc/ -> '$HOME'/rc/'
	rsync -auv ${dstPath}/rc/*          $HOME/rc/
#fi


#if test "$(diff -q $HOME/rc/bashrc $HOME/.bashrc)" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/rc/bashrc/ -> '$HOME'/.bashrc/'
	rsync -auv $HOME/rc/bashrc    $HOME/.bashrc
#fi


#if test "$(diff -q $HOME/rc/vimrc /usr/share/vim/vimrc)" ;then
	cecho -rfn '[+]'
	cecho -gf ${dstPath}'/rc/vimrc/ -> /usr/share/vim/vimrc/'
	rsync -auv $HOME/rc/vimrc     /usr/share/vim/
#fi

