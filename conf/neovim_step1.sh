set -eu
yes | pip install neovim
apt -y install git libtool autoconf automake cmake g++ pkg-config unzip texinfo
cd $HOME
git clone https://github.com/neovim/neovim.git $HOME/repos/neovim
cd $HOME/repos/neovim
yes | make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/bin/neovim"
yes | make install
mkdir -p ~/.config/nvim
