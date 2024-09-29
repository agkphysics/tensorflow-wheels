#!/bin/bash

set -e

usage() {
	echo "Usage: $0 -p <py3_ver> [-b]"
	echo "  -p    Python version to use (8-12)"
	echo "  -b    Warm build (don't clean)"
    echo "  -d    Debug mode"
}

if [ $# -lt 2 ]; then
	usage
	exit
fi

while getopts "hbdp:" opt; do
	case $opt in
		p)
			py3_ver=$OPTARG
			;;
		b)
			warm_build=1
			;;
        d)
            debug_mode=1
            ;;
		h)
			usage
			exit
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			usage
			exit
			;;
	esac
done
if [ "$py3_ver" -lt 8 ] || [ "$py3_ver" -gt 12 ]; then
	echo "Python version must be between 6 and 12"
	usage
	exit
fi

echo "Using Python 3.$py3_ver environment"
if [ "$warm_build" = 1 ]; then
	source venvs/py3${py3_ver}/bin/activate
else
	rm -rf venvs
	python3.${py3_ver} -m venv venvs/py3${py3_ver}
	source venvs/py3${py3_ver}/bin/activate
	pip install -q -r py_build_reqs.txt
fi

export TF_NEED_JEMALLOC=1
export TF_NEED_KAFKA=1
export TF_NEED_OPENCL_SYCL=0
export TF_NEED_OPENCL=0
export TF_NEED_AWS=1
export TF_NEED_GCP=1
export TF_NEED_HDFS=1
export TF_NEED_S3=1
export TF_ENABLE_XLA=1
export TF_NEED_GDR=0
export TF_NEED_VERBS=0
export TF_NEED_MPI=0
export TF_NEED_TENSORRT=1
_tensorrt_maj=$(sed -n -E -e 's/^#define NV_TENSORRT_MAJOR\s+([0-9]+).*/\1/p' /usr/include/NvInferVersion.h)
_tensorrt_min=$(sed -n -E -e 's/^#define NV_TENSORRT_MINOR\s+([0-9]+).*/\1/p' /usr/include/NvInferVersion.h)
export TF_TENSORRT_VERSION=${_tensorrt_maj}.${_tensorrt_min}
export TF_NEED_NGRAPH=0
export TF_NEED_IGNITE=0
export TF_NEED_ROCM=0
export TF_NEED_CLANG=1
export CLANG_COMPILER_PATH=/usr/bin/clang
export TF_SET_ANDROID_WORKSPACE=0
export TF_DOWNLOAD_CLANG=0
_nccl_maj=$(sed -n -E -e 's/^#define NCCL_MAJOR\s+([0-9]+).*/\1/p' /usr/include/nccl.h)
_nccl_min=$(sed -n -E -e 's/^#define NCCL_MINOR\s+([0-9]+).*/\1/p' /usr/include/nccl.h)
export TF_NCCL_VERSION="${_nccl_maj}.${_nccl_min}"
export NCCL_INSTALL_PATH=/usr
GCC_HOST_COMPILER_PATH=$(which gcc)
export GCC_HOST_COMPILER_PATH
HOST_C_COMPILER=$(which gcc)
export HOST_C_COMPILER
HOST_CXX_COMPILER=$(which g++)
export HOST_CXX_COMPILER
export TF_NEED_CUDA=1
export TF_CUDA_CLANG=0  # Clang currently disabled because it's not compatible at the moment.
export CLANG_CUDA_COMPILER_PATH=/usr/bin/clang
export TF_CUDA_PATHS=/usr,/usr/local,/usr/local/cuda
TF_CUDA_VERSION=$(nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')
export TF_CUDA_VERSION
TF_CUDNN_VERSION=$(sed -n -E -e 's/^#define CUDNN_MAJOR\s*(.*).*/\1/p' /usr/include/cudnn_version.h)
export TF_CUDNN_VERSION
export TF_CUDA_COMPUTE_CAPABILITIES=sm_52,sm_53,sm_60,sm_61,sm_62,sm_70,sm_72,sm_75,sm_80,sm_86,sm_87,sm_89,sm_90,compute_90
export TF_PYTHON_VERSION=3.${py3_ver}
echo "TF_PYTHON_VERSION=$TF_PYTHON_VERSION"
PYTHON_BIN_PATH=$(which python)
export PYTHON_BIN_PATH
echo "PYTHON_BIN_PATH=$PYTHON_BIN_PATH"
export USE_DEFAULT_PYTHON_LIB_PATH=1
export CC_OPT_FLAGS="-march=haswell -mavx2 -O3"

echo $(python --version)

if [ "$warm_build" != 1 ]; then
	bazel clean --expunge
fi
if [ "$debug_mode" = 1 ]; then
	bazel_opts=(-s)
fi
./configure
bazel build "${bazel_opts[@]}" --verbose_failures --config=avx_linux -c opt //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package ../wheels/tensorflow

if [ "$warm_build" != 1 ]; then
	bazel clean --expunge
	deactivate
	rm -rf venvs
fi
