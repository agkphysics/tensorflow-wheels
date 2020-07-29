# TensorFlow Wheels
This repository contains python linux wheels for TensorFlow. Most of the
wheels are compiled using the settings from the
[Archlinux PKGBUILDs](https://github.com/archlinux/svntogit-community/blob/packages/tensorflow/trunk/PKGBUILD),
while a few are compiled on an Ubuntu 20.04 system.

| TF | Python | GPU | Compute | CUDA | cuDNN | AVX2 | MKL | TensorRT | File |
|-|-|-|-|-|-|-|-|-|-|
| 1.14.1 | 3.8 | :heavy_check_mark: | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [tensorflow_gpu-1.14.1-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_1.14.1_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6/tensorflow_gpu-1.14.1-cp38-cp38-linux_x86_64.whl) |
| 1.15.0 | 3.8 | :heavy_check_mark: | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [tensorflow_gpu-1.15.0-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_1.15.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6/tensorflow_gpu-1.15.0-cp38-cp38-linux_x86_64.whl) |
| 2.1.0 | 3.8 | :heavy_check_mark: | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 6 | [tensorflow_gpu-2.1.0-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_2.1.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt6/tensorflow_gpu-2.1.0-cp38-cp38-linux_x86_64.whl) |
| 2.2.0 | 3.8 | :heavy_check_mark: | 7.x | 10.2 | 7 | :heavy_check_mark: | :heavy_check_mark: | 7 | [tensorflow-2.2.0-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_2.2.0_gpu_cm7x_cuda102_cudnn7_avx2_mkl_trt7/tensorflow-2.2.0-cp38-cp38-linux_x86_64.whl) |
| 2.4.0 [commit](https://github.com/tensorflow/tensorflow/commit/210cf0a0142af9d1bd21a7de82d5dd0afffc6c68) | 3.8 | :x: | N/A | N/A | N/A | :x: | :x: | N/A | [tensorflow_cpu-2.4.0-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_2.4.0_nogpu_noavx_nomkl/tensorflow_cpu-2.4.0-cp38-cp38-linux_x86_64.whl) |
| 2.3.0 | 3.8 | :heavy_check_mark: | 7.x | 11.0 | 8 | :heavy_check_mark: | :heavy_check_mark: | 7 | [tensorflow-2.3.0-cp38-cp38-linux_x86_64.whl](https://github.com/agkphysics/tensorflow-wheels/releases/download/tf_2.3.0_gpu_cm7x_cuda110_cudnn8_avx2_mkl_trt7/tensorflow-2.3.0-cp38-cp38-linux_x86_64.whl) |
