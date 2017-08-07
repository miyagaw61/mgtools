#!/bin/sh
if test ! -e $HOME/latestvim ;then
    mkdir -p $HOME/latestvim
fi
if test ! -e $HOME/Downloads/vim ;then
    rm -rf $HOME/Downloads/vim
fi
git clone https://github.com/vim/vim.git $HOME/Downloads/vim
cd $HOME/Downloads/vim
git checkout -b 8-0-0886 refs/tags/v8.0.0886
cd src
./configure --enable-multibyte --with-features=huge --disable-selinux --enable-terminal --prefix=$HOME/latestvim && make -j4 && make -j4 install
