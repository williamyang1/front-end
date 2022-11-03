echo "search nvidia.com
nameserver 10.19.185.252" | tee  /etc/resolv.conf
#echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main" |tee //etc/apt/sources.list.d/test.list
apt-get update
apt-get -y install wget
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
#apt-get update
echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main" |tee /etc/apt/sources.list.d/test.list

cd download
dpkg -i cuda-repo-*amd64.deb
cp /var/cuda-repo-ubuntu2004-12-0-local/cuda-94934F21-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cuda-toolkit-12-0
update-alternatives --set cuda /usr/local/cuda-12.0
dpkg -i cudnn-local-repo-ubuntu2004-8.8.0.34_1.0-1_amd64.deb
cp /var/cudnn-local-repo-ubuntu2004-8.8.0.34/cudnn*.gpg /usr/share/keyrings/
apt-get update
apt-get -y install libcudnn8 libcudnn8-dev
cd ..
dpkg -l |grep cuda
ls -l /usr/local/cuda
apt -y install build-essential manpages-dev software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get -y install git
export PATH=/opt/network_repo/cmake-3.24/cmake-3.24.0-linux-x86_64/bin:$PATH
apt-get -y install gcc-11 g++-11
apt-get -y install gcc-9 g++-9
apt -y install clang clang-10
apt -y install clang clang-12

echo "#############RUN TEST###############"
cd cudnn-frontend
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda  ../
cmake --build . -j16
./bin/samples

echo "#############RUN TEST###############"
rm -f /usr/bin/gcc
rm -f /usr/bin/g++
ln -s /usr/bin/gcc-11 /usr/bin/gcc
ln -s /usr/bin/g++-11 /usr/bin/g++
gcc --version
g++ --version
cd ..
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda  ../
cmake --build . -j16
./bin/samples

echo "#############RUN TEST###############"
rm -f /usr/bin/gcc
rm -f /usr/bin/g++
ln -s /usr/bin/gcc-9 /usr/bin/gcc
ln -s /usr/bin/g++-9 /usr/bin/g++
gcc --version
g++ --version
cd ..
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda  ../
cmake --build . -j16
./bin/samples

echo "#############RUN TEST###############"
export CC=/usr/bin/clang-10
export CXX=/usr/bin/clang++-10
cd ..
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda  -DCMAKE_BUILD_TYPE="Debug" VERBOSE=1 ../
cmake --build . -j16
./bin/samples

echo "#############RUN TEST###############"
export CC=/usr/bin/clang-12
export CXX=/usr/bin/clang++-12
cd ..
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda -DCMAKE_BUILD_TYPE="Debug" VERBOSE=1 ../
cmake --build . -j16
./bin/samples
