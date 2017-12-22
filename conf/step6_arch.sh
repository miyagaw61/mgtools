#64bit_only
set -eu
apt -y update
apt -y upgrade
dpkg --add-architecture i386
apt -y update
apt -y install libc6:i386 libncurses5:i386 libstdc++6:i386
apt -y install gcc-multilib g++-multilib
