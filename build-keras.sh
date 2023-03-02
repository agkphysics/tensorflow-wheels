#!/bin/sh

set -e

usage() {
	echo "Usage: $0 -p <py3_ver> -t <tf_ver>"
	echo "  -p <py3_ver>  Python version to use (6-11)"
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
if [ "$py3_ver" -lt 6 ] || [ "$py3_ver" -gt 11 ]; then
	echo "Python version must be between 6 and 11"
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
pip uninstall -q -y keras

bazel clean --expunge
bazel build //keras/tools/pip_package:build_pip_package
./bazel-bin/keras/tools/pip_package/build_pip_package ../wheels/keras
bazel clean --expunge

deactivate
rm -rf venvs
