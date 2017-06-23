#!/bin/sh

hflg=0
#if test $# -eq 0 ;then
#	hflg=1
#fi

for arg in "$@" ;do
	if test "$arg" = "-h" -o "$arg" = "--help" -o "$arg" = "help" ;then
		hflg=1
	fi
done

if test $hflg -eq 1 ;then
	echo -n "Usage: g [file]
"
	exit 0
fi

flg="32"
subflg="64"
if test "$(uname -a | grep x86_64)" ;then
	flg="64"
	subflg="32"
fi

if test "$(file $1 | grep $flg'-bit')" ;then
	gdb -q -x $HOME/mgtools/gdbrc.def -x gdbrc $1
else
	mgpedaconf $subflg
	gdb -q -x $HOME/mgtools/gdbrc.def -x gdbrc $1
	mgpedaconf $flg
fi
