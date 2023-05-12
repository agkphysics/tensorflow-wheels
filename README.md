# TensorFlow Wheels
This repository contains Python Linux wheels for TensorFlow. Most of the
wheels are compiled using modified settings from the
[Archlinux PKGBUILDs](https://github.com/archlinux/svntogit-community/blob/packages/tensorflow/trunk/PKGBUILD).
The build script is `build-tf2-gpu-avx2-mkl.sh`, which builds the
optimised TensorFlow wheel with TensorRT support.

Each release page also has the checksums of the attached files.

## `manylinux2014_x86_64` wheels
The following wheels were compiled in the `manylinux2014_x86_64`
container described below. These should have better glibc
compatibility than the Ubuntu 20.04 ones.

| TF | Python | GPU | CUDA | cuDNN | AVX2 | MKL/oneDNN | TensorRT | Links |
|-|-|-|-|-|-|-|-|-|
| 2.12.0 | 3.11 | 5.2-9.0 | 12.1 | 8.9 | :heavy_check_mark: | :heavy_check_mark: | 8.6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_gpu_cuda12.1_cudnn8.9_avx2_mkl_trt8.6) |
| 2.7.4, 2.8.4, 2.9.3, 2.10.1, 2.11.0 | 3.7-3.11 | 5.2-9.0 | 11.8 | 8.8 | :heavy_check_mark: | :heavy_check_mark: | 8.5 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.7-2.11_gpu_py3x_cuda118_cudnn8_avx2_mkl_trt8) |
| 2.7.4 | 3.6 | 5.2-9.0 | 11.8 | 8.8 | :heavy_check_mark: | :heavy_check_mark: | 8.5 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.7-2.11_gpu_py3x_cuda118_cudnn8_avx2_mkl_trt8) |


## Ubuntu 20.04 wheels
The following wheels were compiled on an Ubuntu 20.04 system

| TF | Python | GPU | CUDA | cuDNN | AVX2 | MKL/oneDNN | TensorRT | Links |
|-|-|-|-|-|-|-|-|-|
| 1.14.1 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_1.14.1_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 1.15.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_1.15.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 2.1.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.1.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 2.2.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 7 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.2.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt7) |
| 2.4.0 [commit](https://github.com/tensorflow/tensorflow/commit/210cf0a0142af9d1bd21a7de82d5dd0afffc6c68) | 3.8 | :x: | :x: | :x: | :x: | :x: | :x: | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.4.0_nogpu_noavx_nomkl) |
| 2.3.0 | 3.8 | 7.x | 11.0 | 8 | :heavy_check_mark: | :heavy_check_mark: | 7 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.3.0_gpu_cm7x_cuda110_cudnn8_avx2_mkl_trt7) |
| 2.4.0 | 3.9 | 7.x | 11.2 | 8 | :heavy_check_mark: | :heavy_check_mark: | :x: | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.4.0_linux_gpu_py39_cm7x_cuda112_cudnn8_avx2_mkl) |
| 2.10.0 | 3.8 | 5.2-8.7 | 11.7 | 8 | :heavy_check_mark: | :heavy_check_mark: | 8 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.10.0_gpu_cuda117_cudnn8_avx2_mkl_trt8) |
| 2.10.0 | 3.9 | 5.2-8.7 | 11.7 | 8 | :heavy_check_mark: | :heavy_check_mark: | 8 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.10.0_gpu_py39_cuda117_cudnn8_avx2_mkl_trt8) |
| 2.10.0 | 3.10 | 5.2-8.7 | 11.7 | 8 | :heavy_check_mark: | :heavy_check_mark: | 8 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.10.0_gpu_py310_cuda117_cudnn8_avx2_mkl_trt8) |
| 2.11.0 | 3.7-3.10 | 5.2-9.0 | 11.8 | 8 | :heavy_check_mark: | :heavy_check_mark: | 8 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.11.0_gpu_py3x_cuda118_cudnn8_avx2_mkl_trt8) |
| 2.11.0 (nightly) | 3.11 | 5.2-9.0 | 11.8 | 8 | :heavy_check_mark: | :heavy_check_mark: | 8 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.11.0-nightly_gpu_py3x_cuda118_cudnn8_avx2_mkl_trt8) |

## `manylinux2014_x86_64` Docker container
The [Dockerfile](./docker/Dockerfile) is based on `manylinux2014_x86_64`
and can be built with the following command, from within the `docker/`
directory:
```
docker build -t tf_build .
```
The container can be run like so:
```
docker run --gpus all -it --rm --tmpfs /tmp:exec -v /path/to/tensorflow:/build -u $(id -u):$(id -g) -e USER=$(id -u) tf_build
```

Then, you can run the build script:
```
cd /path/to/tensorflow
bash build-tf2-gpu-avx2-mkl.sh -p 11
```

The other scripts assume a directory structure as follows:
```
.../
    tensorflow/
        build-tf2-gpu-avx2-mkl.sh
    keras/
        build-keras.sh
    wheels/
        tensorflow/
            *.whl
        keras/
            *.whl
    sanity-check.sh
```

## Patches
The [`patches/`](./patches/) directory contains several patches that fix
bugs and compatibility issues between TensorFlow and different versions
of Python. The `full` subdirectory contains the complete diff used for
each version of TensorFlow and versions of Python.
