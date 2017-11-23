set -eu
bin_path="$HOME/bin"
repos_path="$HOME/repos"
yes | pip install neovim
apt -y install git libtool autoconf automake cmake g++ pkg-config unzip texinfo
git clone https://github.com/neovim/neovim.git $repos_path/neovim
cd $repos_path/neovim
yes | make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$bin_path/neovim"
yes | make install
mkdir -p ~/.config/nvim
