#!/bin/sh

hflg=0

if test $hflg -eq 1 ;then
	echo -n "Usage: f [(None)] [cat] [vim] [etc...]
"
	exit 0
fi

if test $# -eq 0 ;then
    $(cat $HOME/mgtools/.tmp/lsf.out)
    exit 0
fi

$1 $(cat $HOME/mgtools/.tmp/lsf.out)
