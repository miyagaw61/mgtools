#!/bin/sh
hflg=0
sflg=0
sarg=''

if test $# -eq 0 ;then
	hflg=1
fi

while getopts hs: opt ;do
	case $opt in
		h)hflg=1;;
	s)sflg=1; sarg=$OPTARG;;
	esac
done

if [ $hflg -eq 1 ]; then
	echo 'Usage: gc [options] [C_file]
[+]UsageOptions:
   64
   32
   sspoff/canaryoff
   depoff/nxoff
   pie
   fullrelro
   dbg'
	exit 0
fi

options=""

if test $# -ge 2 ;then
	for var in $@ ;do
		if test "$var" = "64" ;then
			options=$options" -m64"
		elif test "$var" = "32" ;then
			options=$options" -m32"
		elif test $var = "depoff" -o $var = "nxoff" ;then
			options=$options" -z execstack"
		elif test $var = "dep" -o $var = "nx" ;then
			options=$options
		elif test $var = "fullrelro" ;then
			options=$options" -Wl,-z,relro,-z,now"
		elif test $var = "relrooff" ;then
			options=$options
		elif test $var = "sspoff" -o $var = "canaryoff" ;then
			options=$options" -fno-stack-protector"
		elif test $var = "ssp" -o $var = "canary" ;then
			options=$options
		elif test $var = "pie" ;then
			options=$options" -fPIE -pie"
		elif test $var = "pieoff" ;then
			options=$options
		elif test $var = "dbg" ;then
			options=$options" -g3 -O0 -static"
		else
			file=$var
		fi
	done
    if test -e gc.conf ;then
        for var in $(cat gc.conf) ;do
            if test "$var" = "64" ;then
                options=$options" -m64"
            elif test "$var" = "32" ;then
                options=$options" -m32"
            elif test $var = "depoff" -o $var = "nxoff" ;then
                options=$options" -z execstack"
            elif test $var = "dep" -o $var = "nx" ;then
                options=$options
            elif test $var = "fullrelro" ;then
                options=$options" -Wl,-z,relro,-z,now"
            elif test $var = "relrooff" ;then
                options=$options
            elif test $var = "sspoff" -o $var = "canaryoff" ;then
                options=$options" -fno-stack-protector"
            elif test $var = "ssp" -o $var = "canary" ;then
                options=$options
            elif test $var = "pie" ;then
                options=$options" -fPIE -pie"
            elif test $var = "pieoff" ;then
                options=$options
            elif test $var = "dbg" ;then
                options=$options" -g3 -O0 -static"
            fi
        done
    fi
    if test "$(echo "$file" | grep -P '\.c$')" ;then
        file=$file
    else
        file=$file.c
    fi
fi

if test $# -eq 1 ;then
    if test "$(echo "$1" | grep -P '\.c$')" ;then
        file=$1
    else
        file=$1.c
    fi
    if test -e gc.conf ;then
        for var in $(cat gc.conf) ;do
            if test "$var" = "32" ;then
                options=$options" -m32"
            elif test $var = "depoff" -o $var = "nxoff" ;then
                options=$options" -z execstack"
            elif test $var = "dep" -o $var = "nx" ;then
                options=$options
            elif test $var = "fullrelro" ;then
                options=$options" -Wl,-z,relro,-z,now"
            elif test $var = "relrooff" ;then
                options=$options
            elif test $var = "sspoff" -o $var = "canaryoff" ;then
                options=$options" -fno-stack-protector"
            elif test $var = "ssp" -o $var = "canary" ;then
                options=$options
            elif test $var = "pie" ;then
                options=$options" -fPIE -pie"
            elif test $var = "pieoff" ;then
                options=$options
            elif test $var = "dbg" ;then
                options=$options" -g3 -O0 -static"
            fi
        done
    fi
fi

out=$(echo $file | sed -E 's/(.*)\.c/\1/')
allrm $out
gcc -I $HOME/mgtools/include/ -W -Wall $options -o $out $file

