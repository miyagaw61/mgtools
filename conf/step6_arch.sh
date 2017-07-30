#64bit_only
dpkg --add-architecture i386
apt-get -y update
apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386
apt-get -y install gcc-multilib g++-multilib
