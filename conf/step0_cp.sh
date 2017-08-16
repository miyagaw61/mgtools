cd $HOME/mgtools
git config --global user.email "miyagaw61@gmail.com"
git config --global user.name "miyagaw61"
cp -a $HOME/mgtools/conf/netrc $HOME/.netrc

cd $HOME/mgtools/conf
echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf

cp -a $HOME/mgtools/conf/rc/bashrc $HOME/.bashrc
#vim
cp -a $HOME/mgtools/conf/rc/vimrc $HOME/.vimrc
if test ! -e $HOME/.vim/bundle/neosnippet-snippets/neosnippets/ ;then
    mkdir -p $HOME/.vim/bundle/neosnippet-snippets/neosnippets/
fi
cp -a $HOME/mgtools/conf/rc/neosnippets/* $HOME/.vim/bundle/neosnippet-snippets/neosnippets/ 
chown -R $USER:$USER $HOME/.vim
chown -R $USER:$USER $HOME/.local
