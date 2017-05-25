#!/bin/sh

hflg=0
if test $# -eq 0 ;then
	hflg=1
fi

dstflg=0
srcflg=0
userflg=0
dst="tmp_image"
src="src_image"
user="miyagaw61"
echo 'RUN echo RUN_START' > cmd.tmp
for arg in "$@" ;do
	if test "$arg" = "-h" -o "$arg" = "--help" -o "$arg" = "help" ;then
		hflg=1

	elif test $dstflg -eq 1 ;then
		dst=$arg
		dstflg=0
	elif test $srcflg -eq 1 ;then
		src=$arg
		srcflg=0
	elif test $userflg -eq 1 ;then
		user=$arg
		userflg=0

	elif test "$arg" = "-d" ;then
		dstflg=1
	elif test "$arg" = "-s" ;then
		srcflg=1	
	elif test "$arg" = "-u" ;then
		userflg=1

	else
		echo 'RUN '$arg >> cmd.tmp
	fi
done

if test $hflg -eq 1 ;then
	echo "Usage: ./"$(basename $0)" -s src -d dst [-u user] [cmd...]
 -s [src]  set source image name
 -d [dst]  set destination image name
 -u [user] set your user name (default: miyagaw61)
 cmd       set RUN command"
	exit 0
fi

cat Dockerfile.def | perl -pe 's/IMAGE/'$src'/g' > Dockerfile
cat cmd.tmp >> Dockerfile
docker build -t $dst .
