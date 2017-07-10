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

if test "$(file $1 | grep '64-bit')" ;then
	gdb -q -x $HOME/mgtools/gdbrc.def -x gdbrc $1
else
	gdb -q -x $HOME/mgtools/gdbrc.def -x gdbrc $1
fi
