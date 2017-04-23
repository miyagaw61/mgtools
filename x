#!/bin/sh
hflg=0
sflg=0
sarg=''

if test -f ./a.out ;then
	rm a.out
fi

while getopts hs: opt ;do
	case $opt in
		h)hflg=1;;
	s)sflg=1; sarg=$OPTARG;;
	esac
done

if [ $hflg -eq 1 ]; then
	echo 'Usage: x [option] $file_name\n -s[nodep/norelro/nossp/nopie]: set_option'
	exit 0
fi

if [ $sflg -eq 1 ]; then
	if [ $sarg = 'nodep' ]; then
		shift $(($OPTIND - 1))
		gcc -I ~/bin/include/ -fno-stack-protector $1
		./a.out
		rm a.out
		exit 0
	fi
fi

gcc -I ~/bin/include/ $1

argv=''
for arg in $@ ;do
	argv=$argv' '$arg
done

./a.out $argv 
rm a.out
