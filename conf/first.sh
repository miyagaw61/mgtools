cd $HOME/mgtools
git config --global user.email "miyagaw61@gmail.com"
git config --global user.name "miyagaw61"

cd $HOME/mgtools/conf
echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf

cp -a $HOME/mgtools/conf/rc/bashrc $HOME/.bashrc
cp -a $HOME/mgtools/conf/rc/vimrc /etc/vim/vimrc
cp -a $HOME/mgtools/conf/rc/vimrc /usr/share/vim/vimrc
if test ! -e $HOME/.vim/bundle/neosnippet-snippets/neosnippets/ ;then
    mkdir -p $HOME/.vim/bundle/neosnippet-snippets/neosnippets/
fi
cp -a $HOME/mgtools/conf/rc/neosnippets/* $HOME/.vim/bundle/neosnippet-snippets/neosnippets/ 

./step1_apt.sh
./step2_curl.sh
./step3_pip.sh
./step4_git.sh
./step5_wget.sh

#64bit only
./step6_arch.sh
