set -eu
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x ./installer.sh
./installer.sh $HOME/.deinvim/dein
rm ./installer.sh
chown -R $(basename $HOME):$(basename $HOME) $HOME/.deinvim
chown -R $(basename $HOME):$(basename $HOME) $HOME/.config
chown -R $(basename $HOME):$(basename $HOME) $HOME/.local
chown -R $(basename $HOME):$(basename $HOME) $HOME/.vim
cp -a $MGTOOLS_ROOT/conf/rc/dein.toml $HOME/.deinvim
cp -a $MGTOOLS_ROOT/conf/rc/dein_lazy.toml $HOME/.deinvim
cp -a $MGTOOLS_ROOT/conf/rc/init.vim $HOME/.config/nvim
