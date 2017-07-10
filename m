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
	echo -n "Usage: m [str]
"
	exit 0
fi

man -k $1 > m.tmp
cat m.tmp | while read var ;do
    num=$(echo $var | grep -P '^'$1'\s' | perl -pe 's@^.*\((.*)\).*@\1@g')
    if test "$num" = "2" ;then
        man 2 $1 > m.vim.tmp
    elif test "$num" = "3" ;then
        man 3 $1 > m.vim.tmp
    fi
done
allrm m.tmp
