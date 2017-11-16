#wget

cd $HOME/Downloads/

wget https://github.com/downloads/0vercl0k/rp/rp-lin-x86
chmod +x rp-lin-x86
mv rp-lin-x86 /usr/local/bin/
curl -L https://github.com/downloads/0vercl0k/rp/rp-lin-x64 > rp-lin-x64
chmod +x rp-lin-x64
mv rp-lin-x64 /usr/local/bin/

wget https://github.com/slimm609/checksec.sh/archive/1.6.tar.gz
tar zxvf 1.6.tar.gz
mv checksec.sh-1.6/checksec $HOME/repos/mgtools/checksec.sh

mkdir ext4magic
cd ext4magic
wget http://downloads.sourceforge.net/project/ext4magic/ext4magic-0.3.2.tar.gz
tar xzvf ext4magic-0.3.2.tar.gz
cd ext4magic-0.3.2
./configure

#jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
apt -y update
apt -y install jenkins
