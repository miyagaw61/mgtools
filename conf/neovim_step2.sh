curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x ./installer.sh
./installer.sh $HOME/.deinvim/dein
chown -R $(basename $HOME):$(basename $HOME) $HOME/.deinvim
chown -R $(basename $HOME):$(basename $HOME) $HOME/.config
chown -R $(basename $HOME):$(basename $HOME) $HOME/.local
