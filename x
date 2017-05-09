#!/bin/sh

hflg=0

if test -f ./a.out ;then
	rm a.out
fi

if test $# -eq 0 ;then
	hflg=1
fi

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done

if test $hflg -eq 1 ;then
	gc -h | perl -pe 's/gc/x/g'
	exit 0
fi

argv=''
for var in $@ ;do
	if test "$(echo $var | grep -P '.*\.c')" ;then
		file="$(echo $var | perl -pe 's/(.*)\.c/\1/g')"
	else
		argv=$argv" "$var
	fi
done

gc $@

cecho -gf '\n##### START #####\n'
./$file $argv 
