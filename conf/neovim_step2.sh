set -eu
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x ./installer.sh
./installer.sh $HOME/.cache/dein
rm ./installer.sh
chown -R $(basename $HOME):$(basename $HOME) $HOME/.cache
chown -R $(basename $HOME):$(basename $HOME) $HOME/.config
chown -R $(basename $HOME):$(basename $HOME) $HOME/.local
chown -R $(basename $HOME):$(basename $HOME) $HOME/.vim
cp -a $MGTOOLS_ROOT/conf/rc/vim/plugins/dein.toml $HOME/.cache/dein/
cp -a $MGTOOLS_ROOT/conf/rc/vim/plugins/dein_lazy.toml $HOME/.cache/dein/
cp -a $MGTOOLS_ROOT/conf/rc/vim/plugins/init.vim $HOME/.config/nvim/
