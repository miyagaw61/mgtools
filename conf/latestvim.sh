#!/bin/sh
if test ! -e $HOME/latestvim ;then
    mkdir -p $HOME/latestvim
fi
git clone https://github.com/vim/vim.git
cd vim
git checkout -b 8-0-0886 refs/tags/v8.0.0886
./configure --enable-multibyte --with-features=huge --disable-selinux --enable-terminal --prefix=/home/miyagaw61/latestvim && make -j4 && make -j4 install
