#!/bin/bash

set -e

usage() {
    echo "Usage: $0 -p <py3_ver> -t <tf_ver> -k <keras_ver>"
    echo "  -p <py3_ver>  Python version to use (6-11)"
    echo "  -t            TensorFlow version to use (2.3.0, 2.4.0, etc.)"
    echo "  -k            Keras version to use (2.4.3, 2.4.0, etc.)"
}

if [ $# -lt 6 ]; then
    usage
    exit
fi

while getopts "ht:p:k:" opt; do
	case $opt in
		p)
			py3_ver=$OPTARG
			;;
        t)
            tf_ver=$OPTARG
            ;;
        k)
            keras_ver=$OPTARG
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
tf_wheel=$(ls wheels/tensorflow/tensorflow-${tf_ver}-cp3${py3_ver}-*-linux_x86_64.whl)
if [ ! -f "$tf_wheel" ]; then
    echo "TensorFlow wheel $tf_wheel not found"
    exit 1
fi
keras_wheel=$(ls wheels/keras/keras-${keras_ver}-*.whl)
if [ ! -f "$keras_wheel" ]; then
    echo "Keras wheel $keras_wheel not found"
    exit 1
fi

PIP_OPTS=(--disable-pip-version-check --no-cache-dir)

python -m pip "${PIP_OPTS[@]}" install -q -U pip
pip "${PIP_OPTS[@]}" install -q -U "$tf_wheel" "$keras_wheel"

python -c 'import tensorflow as tf; print(tf.__version__); print(tf.keras.__version__); print(tf.constant(1));'

deactivate
rm -rf venvs
