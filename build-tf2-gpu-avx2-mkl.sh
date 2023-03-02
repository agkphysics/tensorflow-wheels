#!/bin/sh

set -e

usage() {
	echo "Usage: $0 -p <py3_ver> [-b]"
	echo "  -p <py3_ver>  Python version to use (6-11)"
	echo "  -b            Warm build (don't clean)"
}

if [ $# -lt 2 ]; then
	usage
	exit
fi

while getopts "hbp:" opt; do
	case $opt in
		p)
			py3_ver=$OPTARG
			;;
		b)
			warm_build=1
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
if [ "$py3_ver" -lt 6 ] || [ "$py3_ver" -gt 11 ]; then
	echo "Python version must be between 6 and 11"
	usage
	exit
fi

if [ "$warm_build" = 1 ]; then
	source venvs/py3${py3_ver}/bin/activate
else
	rm -rf venvs
	python3.${py3_ver} -m venv venvs/py3${py3_ver}
	source venvs/py3${py3_ver}/bin/activate
	pip install -q -r py_build_reqs.txt
	_tag=$(git describe --tags)
	tf_ver=$(echo "$_tag" | sed -n -E -e 's/^v2\.([0-9]+).*/\1/p')
	if [ "$tf_ver" = "7" ]; then
		pip install -q keras-preprocessing
	fi
fi

PYTHON_BIN_PATH=$(which python)
export PYTHON_BIN_PATH
export USE_DEFAULT_PYTHON_LIB_PATH=1
export TF_NEED_JEMALLOC=1
export TF_NEED_KAFKA=0
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
export TF_NEED_NGRAPH=0
export TF_NEED_IGNITE=0
export TF_NEED_ROCM=0
export TF_SET_ANDROID_WORKSPACE=0
export TF_DOWNLOAD_CLANG=0
_nccl_maj=$(sed -n -E -e 's/^#define NCCL_MAJOR\s*(.*).*/\1/p' /usr/include/nccl.h)
_nccl_min=$(sed -n -E -e 's/^#define NCCL_MINOR\s*(.*).*/\1/p' /usr/include/nccl.h)
export TF_NCCL_VERSION="${_nccl_maj}.${_nccl_min}"
export TF_IGNORE_MAX_BAZEL_VERSION=1
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
export CC_OPT_FLAGS="-march=haswell -O3"

if [ "$warm_build" != 1 ]; then
	bazel clean --expunge
fi
./configure
bazel build --config=mkl --config=avx2_linux -c opt //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package ../wheels/tensorflow

if [ "$warm_build" != 1 ]; then
	bazel clean --expunge
	deactivate
	rm -rf venvs
fi
