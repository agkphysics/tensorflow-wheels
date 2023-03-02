#!/bin/sh

cd /build
curl -L -O "https://github.com/xianyi/OpenBLAS/releases/download/v0.3.21/OpenBLAS-0.3.21.tar.gz"
tar xzf OpenBLAS-0.3.21.tar.gz
cd OpenBLAS-0.3.21
cmake -B build -S . \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_WITHOUT_LAPACK=ON \
	-DBUILD_WITHOUT_CBLAS=ON \
	-DBUILD_TESTING=OFF \
	-DNO_AFFINITY=ON \
	-DUSE_OPENMP=1 \
	-DNO_WARMUP=1 \
	-DCORE=HASWELL \
	-DNUM_THREADS=256 \
	-DDYNAMIC_ARCH=ON
cmake --build build -j 256
cmake --install build
cmake -B build64 -S . \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_WITHOUT_LAPACK=ON \
        -DBUILD_WITHOUT_CBLAS=ON \
        -DBUILD_TESTING=OFF \
        -DNO_AFFINITY=ON \
        -DUSE_OPENMP=1 \
        -DNO_WARMUP=1 \
        -DCORE=HASWELL \
        -DNUM_THREADS=256 \
        -DDYNAMIC_ARCH=ON \
	-DINTERFACE64=1
cmake --build build64 -j 256
cmake --install build64

cd /build
curl -L -o lapack-3.11.0.tar.gz "https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.11.0.tar.gz"
tar xzf lapack-3.11.0.tar.gz
cd lapack-3.11.0
cmake -B build -S . \
	-DCMAKE_SKIP_RPATH=ON \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF \
	-DCMAKE_Fortran_COMPILER=gfortran \
	-DLAPACKE_WITH_TMG=ON \
	-DLAPACKE_WITH_TMG=ON \
	-DBUILD_DEPRECATED=ON
cmake --build build -j 256
cmake --install build
cmake -B build64 -S . \
        -DCMAKE_SKIP_RPATH=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_TESTING=OFF \
        -DCMAKE_Fortran_COMPILER=gfortran \
        -DLAPACKE_WITH_TMG=ON \
        -DLAPACKE_WITH_TMG=ON \
        -DBUILD_DEPRECATED=ON \
	-DBUILD_INDEX64=ON
cmake --build build64 -j 256
cmake --install build64

cd /build
curl -L -O "https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.7/llvm-project-15.0.7.src.tar.xz"
tar xJf llvm-project-15.0.7.src.tar.xz
cd llvm-project-15.0.7.src
cmake -B build -S . \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_BUILD_TARGETS=X86 \
	-DLLVM_ENABLE_PROJECTS="openmp;clang"
cmake --build build -t omp -t omptarget -j 256
cmake --install build
