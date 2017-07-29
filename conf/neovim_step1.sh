yes | pip3 install neovim
apt-get -y install git libtool autoconf automake cmake g++ pkg-config unzip  
cd ~/
git clone https://github.com/neovim/neovim.git
cd neovim
yes | make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
yes | make install
mkdir -p ~/.config/nvim
