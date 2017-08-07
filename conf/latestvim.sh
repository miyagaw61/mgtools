#!/bin/sh
if test -e $HOME/latestvim ;then
    rm -rf $HOME/latestvim
fi
mkdir -p $HOME/latestvim
if test -e $HOME/Downloads/vim ;then
    rm -rf $HOME/Downloads/vim
fi
git clone https://github.com/vim/vim.git $HOME/Downloads/vim
cd $HOME/Downloads/vim
git checkout -b 8-0-0886 refs/tags/v8.0.0886
cd src
apt-get -y install lua5.1 luajit liblua5.1-0 liblua5.1-0-dev ruby2.3 ncurses-dev libluajit-5.1-dev
./configure --enable-multibyte --with-features=huge --disable-selinux --enable-terminal --enable-perlinterp=dynamic --enable-rubyinterp=dynamic --with-ruby-command=/usr/bin/ruby2.3 --enable-pythoninterp=dynamic --enable-luainterp=dynamic --with-luajit --enable-gpm --enable-cscope --enable-fontset --prefix=$HOME/latestvim && make -j4 && make -j4 install
