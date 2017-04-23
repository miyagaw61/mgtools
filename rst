#!/bin/sh

hflg=0

while getopts h opt ;do
	case $opt in
		h)hflg=1;;
	esac
done
shift $(($OPTIND - 1))

if test $hflg -eq 1 ;then
	echo "Usage: rst"
	exit 0
fi

echo -n "Now Restoreing ... "

cp -a /mnt/windows/bk/* ~/
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

cp -a ~/rc/bashrc ~/.bashrc
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

cp -a ~/rc/vimrc /etc/vim/vimrc
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

cp -a ~/neosnippets/* ~/.vim/bundle/neosnippet-snippets/neosnippets/
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

cp -a ~/rc/gdbinit ~/.gdbinit
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

cp -a ~/bk/peda/peda.py ~/peda/peda.py
echo -n .
perl -MTime::HiRes -e 'Time::HiRes::sleep(0.5)'
echo -n .

echo FINISH!
sleep 0.5
