#!/bin/sh

hflg=0
#if test $# -eq 0 ;then
#	hflg=1
#fi

aflg=0
bflg=0
cflg=0
varA=""
varB="hoge"
varC="fuga"
for arg in "$@" ;do
	if test "$arg" = "-h" -o "$arg" = "--help" -o "$arg" = "help" ;then
		hflg=1

	elif test $aflg -eq 1 ;then
		varA=$arg
		aflg=0
	elif test $bflg -eq 1 ;then
		varB=$arg
		bflg=0
	elif test $cflg -eq 1 ;then
		varC=$arg
		cflg=0

	elif test "$arg" = "-a" ;then
		aflg=1
	elif test "$arg" = "-b" ;then
		bflg=1
	elif test "$arg" = "-c" ;then
		cflg=1

	else
		echo '[+]'$arg
	fi
done

if test $hflg -eq 1 ;then
	echo "Usage: ./"$(basename $0)" [-h] -a argA [-b argB] [-c argC] expr...
 -h        show help
 -a [argA] set arg1
 -b [argB] set arg2
 -c [argC] set arg3
 expr      set expr"
	exit 0
fi

if test ! "$varA" ;then
	echo varA is empty!
	exit 0
fi

echo varA is $varA
echo varB is $varB
echo varC is $varC

