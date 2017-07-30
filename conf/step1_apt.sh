#apt-get -y update
#apt-get -y upgrade
apt-get -y -o Acquire::ForceIPv4=true update
apt-get -y -o Acquire::ForceIPv4=true upgrade

cp -a $HOME/mgtools/conf/rc/bashrc $HOME/.bashrc
#apt-get -y install vim
cp -a $HOME/mgtools/conf/rc/vimrc /etc/vim/vimrc
cp -a $HOME/mgtools/conf/rc/vimrc /usr/share/vim/vimrc
if ! -e $HOME/.vim/bundle/neosnippet-snippets/neosnippets/ ;then
	mkdir -p $HOME/.vim/bundle/neosnippet-snippets/neosnippets/
fi
--
#apt

apt-get -y install rsync
apt-get -y install python
apt-get -y install python-pip python-dev
apt-get -y install libboost-all-dev lib32z1-dev libbz2-dev
apt-get -y install git
apt-get -y install curl
apt-get -y install gcc
apt-get -y install socat
apt-get -y install binutils
apt-get -y install bsdmainutils
apt-get -y install perl
apt-get -y install nasm
apt-get -y install tree
apt-get -y install vim-gtk vim-athena vim-gnome
apt-get -y install nmap
apt-get -y install traceroute
apt-get -y install gdb
apt-get -y install gdbserver
apt-get -y install autoconf
apt-get -y install libtool
apt-get -y install make
apt-get -y install openssh-server
#apt-get -y install terminator 
apt-get -y install ext4magic 
apt-get -y install libfreetype6-dev
apt-get -y install libpng-dev
apt-get -y install build-essential
apt-get -y install binwalk
apt-get -y install cifs-utils
apt-get -y install chromium-browser
apt-get -y install docker.io
apt-get -y install ucommon-utils
apt-get -y install xclip
apt-get -y install libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
apt-get -y install libtool-bin

###---kernel develop---###
apt-get -y install libncurses5-dev
apt-get -y install fakeroot
apt-get -y install linux-headers-generic
apt-get -y install linux-headers-$(uname -r)

###----for metasploit----#
#apt-get -y install subversion
#apt-get -y install libreadline-dev
#apt-get -y install libpq5
#apt-get -y install libpq-dev
#apt-get -y install libreadline5
#apt-get -y install libsqlite3-dev
#apt-get -y install libpcap-dev
#apt-get -y install git-core
#apt-get -y install postgresql
#apt-get -y install pgadmin3
#apt-get -y install zlib1g-dev
#apt-get -y install libxml2-dev
#apt-get -y install libxslt1-dev
#apt-get -y install vncviewer
#apt-get -y install libyaml-dev
#apt-get -y install openjdk-8-jre
#apt-get -y install gem
#apt-get -y install gem2deb gemanx-gtk2 gem-dev gemdropx gem-extra gem-plugin-dc1394 gem-plugin-dv4l gem-plugin-gmerlin
#apt-get -y install rbenv
#apt-get -y install libffi-dev
#	#openjdk-8-jre error
#	  #add-apt-repository ppa:openjdk-r/ppa
#	  #apt-get update
#	  #apt-get install openjdk-8-jre
