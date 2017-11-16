#git
git clone https://github.com/junegunn/fzf.git $HOME/.fzf
yes | $HOME/.fzf/install
patch -u  $HOME/.fzf/shell/completion.bash < $HOME/repos/mgtools/conf/fzf_completion.pat 
patch -u $HOME/.fzf/shell/key-bindings.bash < $HOME/repos/mgtools/conf/fzf_key-bindings.pat

git clone https://github.com/radare/radare2.git $HOME/radare2
sh $HOME/radare2/sys/install.sh

git clone https://github.com/yyuu/pyenv.git ~/.pyenv

cd $HOME/Downloads
git clone https://github.com/icholy/ttygif.git
cd ttygif
make
make install

