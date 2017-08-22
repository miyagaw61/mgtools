pip install pygments
#please download https://www.gnu.org/software/global/download.html -> global.*tar.gz
cd global-\d.*
./configure
make install
cp -a  global/global /usr/local/bin
cp -a  gtags/gtags /usr/local/bin
mkdir -p ~/.vim/plugin
cp gtags.vim ~/.vim/plugin
wget https://raw.githubusercontent.com/yoshizow/global-pygments-plugin/master/sample.globalrc
mv sample.globalrc $HOME/.globalrc
