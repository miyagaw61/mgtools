#!/bin/sh

hflg=0
if test $# -eq 0 ;then
	hflg=1
fi

aflg=0
varA=""
for arg in "$@" ;do
	if test "$arg" = "-h" -o "$arg" = "--help" -o "$arg" = "help" ;then
		hflg=1

	elif test $aflg -eq 1 ;then
		varA=$arg
		aflg=0

	elif test "$arg" = "-a" ;then
		aflg=1

	fi
done

if test $hflg -eq 1 ;then
	echo -n "Usage: vic [file]
"
	exit 0
fi

vim $1.c
