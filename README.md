# TensorFlow Wheels
This repository contains python linux wheels for TensorFlow. Most of the
wheels are compiled using the settings from the
[Archlinux PKGBUILDs](https://github.com/archlinux/svntogit-community/blob/packages/tensorflow/trunk/PKGBUILD),
while a few are compiled on an Ubuntu 20.04 system.

Each release page gives info about the SHA1 and MD5 checksums of the
attached files.

| TF | Python | GPU | CUDA | cuDNN | AVX2 | MKL | TensorRT | Links |
|-|-|-|-|-|-|-|-|-|
| 1.14.1 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_1.14.1_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 1.15.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_1.15.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 2.1.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.1.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6) |
| 2.2.0 | 3.8 | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 7 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.2.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt7) |
| 2.4.0 [commit](https://github.com/tensorflow/tensorflow/commit/210cf0a0142af9d1bd21a7de82d5dd0afffc6c68) | 3.8 | :x: | :x: | :x: | :x: | :x: | :x: | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.4.0_nogpu_noavx_nomkl) |
| 2.3.0 | 3.8 | 7.x | 11.0 | 8 | :heavy_check_mark: | :heavy_check_mark: | 7 | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.3.0_gpu_cm7x_cuda110_cudnn8_avx2_mkl_trt7) |
| 2.4.0 | 3.9 | 7.x | 11.2 | 8 | :heavy_check_mark: | :heavy_check_mark: | :x: | [Release](https://github.com/agkphysics/tensorflow-wheels/releases/tag/tf_2.4.0_linux_gpu_py39_cm7x_cuda112_cudnn8_avx2_mkl) |
