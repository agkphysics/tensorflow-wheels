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
pip install -q --ignore-requires-python "$tf_wheel"
pip uninstall -q -y tensorflow-text

bazel clean --expunge
./oss_scripts/run_build.sh
mv tensorflow_text-*.whl ../wheels/text
bazel clean --expunge

deactivate
rm -rf venvs
