#!/bin/sh
if test -e $HOME/viim ;then
    rm -rf $HOME/viim
fi
mkdir -p $HOME/viim
if test -e $HOME/Downloads/vim ;then
    rm -rf $HOME/Downloads/vim
fi
git clone https://github.com/vim/vim.git $HOME/Downloads/vim
cd $HOME/Downloads/vim
git checkout -b 8-0-0886 refs/tags/v8.0.0886
cd src
apt-get -y install lua5.1 luajit liblua5.1-0 liblua5.1-0-dev ruby2.3 libruby ncurses-dev libluajit-5.1-dev vim-nox gir1.2-gtk-2.0 gir1.2-gtk-3.0 libgail-3-0 libgail-3-dev libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk-3-dev xorg-dev ruby-dev perl-depends libperl-dev
yum -y install perl-devel.i686 perl-devel.x86_64
yum -y install perl-dev perl-ExtUtils-Embed.noarch
yum -y install ruby ruby-devel.x86_64
yum -y install python-devel.x86_64
yum -y install lua-devel.i686 lua-devel.x86_64
yum -y install gtk2-devel
yum -y install gtk2.i686
yum -y install ncurses-devel
yum -y install atk-devel.i686 libX11-devel.i686 libXt-devel.i686 libXt-devel.x86_64
yum -y install expat-devel.i686 gettext-devel.i686 gettext-devel.x86_64 openssl-perl.x86_64 openssl-devel.i686
yum -y install python34-devel.x86_64
./configure --enable-multibyte --with-features=huge --disable-selinux --enable-terminal --enable-perlinterp --enable-rubyinterp=dynamic --with-ruby-command=$(which ruby) --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-luainterp=dynamic --with-luajit --enable-gpm --enable-cscope --enable-fontset --enable-xim --enable-gui=gtk2 --prefix=$HOME/viim && make -j4 && make -j4 install
