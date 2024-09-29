#!/bin/sh

set -e

usage() {
	echo "Usage: $0 -p <py3_ver> -t <tf_ver>"
	echo "  -p <py3_ver>  Python version to use (6-12)"
	echo "  -t <tf_ver>   TensorFlow version to use (2.3.0, 2.4.0, etc.)"
}

if [ $# -lt 4 ]; then
	usage
	exit
fi

while getopts "ht:p:" opt; do
	case $opt in
	p)
		py3_ver=$OPTARG
		;;
        t)
		tf_ver=$OPTARG
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
if [ "$py3_ver" -lt 6 ] || [ "$py3_ver" -gt 12 ]; then
	echo "Python version must be between 6 and 12"
	usage
	exit
fi

rm -rf venvs
python3.$py3_ver -m venv venvs/py3$py3_ver
. venvs/py3${py3_ver}/bin/activate

# Get most recent wheel
tf_wheel=$(ls ../wheels/tensorflow/tensorflow-${tf_ver}-cp3${py3_ver}-*-linux_x86_64.whl)
echo "Installing TensorFlow wheel $tf_wheel"
pip install -q "$tf_wheel"
pip uninstall -q -y tensorflow-io tensorflow-io-gcs-filesystem

bazel clean --expunge
python tools/build/configure.py
bazel build --config=linux --config=optimization --copt="-mavx" --copt="-mavx2" --copt="-Wno-error=dangling-pointer=" --copt="-Wno-error=array-bounds=" --copt="-Wno-error=array-parameter=" --copt="-I/usr/include/tirpc" //tensorflow_io/... //tensorflow_io_gcs_filesystem/...
python setup.py bdist_wheel --data bazel-bin --project tensorflow-io
python setup.py bdist_wheel --data bazel-bin --project tensorflow-io-gcs-filesystem
mv dist/tensorflow_io*.whl ../wheels/io
bazel clean --expunge

deactivate
rm -rf venvs
