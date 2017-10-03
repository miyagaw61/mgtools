apt -y install software-properties-common
add-apt-repository -y ppa:git-core/ppa
apt -y update
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt -y install git-lfs
git lfs install
