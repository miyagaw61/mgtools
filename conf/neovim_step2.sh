curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x ./installer.sh
./installer.sh $HOME/.deinvim/dein
rm ./installer.sh
chown -R $(basename $HOME):$(basename $HOME) $HOME/.deinvim
chown -R $(basename $HOME):$(basename $HOME) $HOME/.config
chown -R $(basename $HOME):$(basename $HOME) $HOME/.local
cp -a $HOME/mgtools/conf/rc/dein.toml $HOME/.deinvim
cp -a $HOME/mgtools/conf/rc/dein_lazy.toml $HOME/.deinvim
cp -a $HOME/mgtools/conf/rc/init.vim $HOME/.config/nvim
pyenv install 3.5.0
