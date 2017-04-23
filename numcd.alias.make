#!/bin/sh

hflg=0

#if test $# -eq 0 ;then
#	hflg=1
#fi

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done
shift $(($OPTIND - 1))

if test $hflg -eq 1 ;then
	echo "Usage: tmp.sh [option]"
	exit 0
fi

for var in $(seq 1 500) ;do
	echo 'alias '${var}'="cat ~/bin/numcd | grep '${var}' | perl -pe '$(echo "'")'s@\d+:\ (.*)@\1@g'$(echo "'")' | /bin/bash"'
done

#alias 1="cat ~/bin/numcd | grep 1 | perl -pe 's@.*:\ (.*)@\1@g'"
