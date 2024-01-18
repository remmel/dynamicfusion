#!/bin/bash

# Build and Install script tested on Ubuntu 22.04 LTS

sudo apt update
sudo apt install nvidia-cuda-dev nvidia-cuda-toolkit
# install git, cmake, SuiteSparse, Lapack, BLAS etc
sudo apt install cmake libvtk7-dev libsuitesparse-dev liblapack-dev libblas-dev libgtk2.0-dev pkg-config libopenni-dev libusb-1.0-0-dev wget zip clang


# Install Ceres, OpenCV and Boost
sudo apt install libceres-dev libopencv-dev libboost-dev

# Build DynamicFusion

cd dynamicfusion/deps

# Get terra
wget https://github.com/terralang/terra/releases/download/release-1.1.1/terra-Linux-x86_64-094c5ad.tar.xz
tar -xf terra-Linux-x86_64-094c5ad.tar.xz
rm terra-Linux-x86_64-094c5ad.tar.xz
mv terra-Linux-x86_64-094c5ad terra


# Build Opt
#	Change line
#		FLAGS += -O3 -g -std=c++11 -I$(SRC) -I$(SRC)/cutil/inc -I../../API/release/include -I$(TERRAHOME)/include -I$(CUDAHOME)/include -I../external/mLib/include -I../external -I../external/OpenMesh/include
#	with
#		FLAGS += -D_MWAITXINTRIN_H_INCLUDED -D_FORCE_INLINES -D__STRICT_ANSI__ -O3 -g -std=c++11 -I$(SRC) -I$(SRC)/cutil/inc -I../../API/release/include -I$(TERRAHOME)/include -I$(CUDAHOME)/include -I../external/mLib/include -I../external -I../external/OpenMesh/include

cd Opt/API/
sed -i 's/, usemcjit = 1//g' src/createwrapper.t #remove usemcjit
make -j4
cd ../../../

mkdir -p build && cd build
cmake ..
make -j4
cd ..
