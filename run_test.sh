echo "search nvidia.com
nameserver 10.19.185.252" | tee  /etc/resolv.conf
#echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu focal main" |tee //etc/apt/sources.list.d/test.list
apt-get update
apt-get -y install wget
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
apt-get update
echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main" |tee /etc/apt/sources.list.d/test.list

apt -y install build-essential manpages-dev software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update

apt-get -y install git
export PATH=/opt/network_repo/cmake-3.24/cmake-3.24.0-linux-x86_64/bin:$PATH
apt-get -y install gcc-11 g++-11
apt-get -y install gcc-9 g++-9
apt -y install clang clang-10
apt -y install clang clang-12

cd cudnn-frontend
echo "#############RUN TEST###############"
rm -rf build
mkdir build
cd build
cmake -DCUDNN_PATH=/usr/local/cuda -DCUDAToolkit_ROOT=/usr/local/cuda  ../
cmake --build . -j16
./bin/samples
cd ..

echo "#############RUN TEST###############"
rm -f /usr/bin/gcc
rm -f /usr/bin/g++
ln -s /usr/bin/gcc-11 /usr/bin/gcc
ln -s /usr/bin/g++-11 /usr/bin/g++
gcc --version
g++ --version
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