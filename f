#!/bin/sh

hflg=0

if test $# -eq 0 ;then
	hflg=1
fi

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done
shift $(($OPTIND - 1))

if test $hflg -eq 1 ;then
	echo "Usage: "
	exit 0
fi

for var in $@ ;do
	if test "$(cat ~/bin/numcd | egrep ^${var}: | egrep -e ':\ cat' -e ':\ cd')" ;then
		cat ~/bin/numcd | grep ^${var}: |  perl -pe 's@\d+:\ .*\ (.*)@\1@g'
	else
		cat ~/bin/numcd | grep ^${var}: |  perl -pe 's@\d+:\ (.*)@\1@g'
	fi
done
