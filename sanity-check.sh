#!/bin/bash

set -e

usage() {
	echo "Usage: $0 -p <py3_ver> -t <tf_ver> -k <keras_ver> -x <text_ver>"
	echo "  -p    Python version to use (6-12)"
	echo "  -t    TensorFlow version to use (e.g. 2.3.0)"
	echo "  -x    TF-Text version to use"
}

if [ $# -lt 6 ]; then
	usage
	exit
fi

while getopts "ht:p:x:" opt; do
	case $opt in
	p)
		py3_ver=$OPTARG
		;;
	t)
		tf_ver=$OPTARG
		;;
	x)
		text_ver=$OPTARG
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
tf_wheel=$(ls wheels/tensorflow/tensorflow-${tf_ver}-cp3${py3_ver}-*-linux_x86_64.whl)
if [ ! -f "$tf_wheel" ]; then
	echo "TensorFlow wheel $tf_wheel not found"
	exit 1
fi
text_wheel=$(ls wheels/text/tensorflow_text-${text_ver}-cp3${py3_ver}-*-linux_x86_64.whl)
if [ ! -f "$text_wheel" ]; then
	echo "Tensorflow Text wheel $text_wheel not found"
	exit 1
fi

PIP_OPTS=(--disable-pip-version-check --no-cache-dir)

python -m pip "${PIP_OPTS[@]}" install -q -U pip
pip "${PIP_OPTS[@]}" install -q -U "$tf_wheel" "$text_wheel"

python -c 'import tensorflow as tf; import tensorflow_text; print(tf.__version__); print(tf.keras.__version__); print(tf.constant(1));'

deactivate
rm -rf venvs
