#!/bin/sh

hflg=0
#if test $# -eq 0 ;then
#	hflg=1
#fi

aflg=0
dflg=0
xflg=0
oflg=0
lstflg=0

case $1 in
a);;
d);;
x);;
o);;
*)lstflg=1;;
esac

if test $lstflg -eq 1 ;then
    lst=$(echo $1 | perl -pe 's@(.)@\1 @g')
    for var in $lst ;do
        case $var in
        d) dflg=1;;
        x) xflg=1;;
        o) oflg=1;;
        a) aflg=1;;
        h) hflg=1;;
        esac
    done
else
    for var in $@ ;do
        case $var in
        d) dflg=1;;
        x) xflg=1;;
        o) oflg=1;;
        a) aflg=1;;
        h) hflg=1;;
        esac
    done
fi

if test $hflg -eq 1 ;then
	echo -n "Usage: al2jp [file]
"
    rmtmp
	exit 0
fi

