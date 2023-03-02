FROM quay.io/pypa/manylinux2014_x86_64

RUN yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo \
	&& yum clean all \
	&& yum -y install cuda-11-8 libcudnn8-devel tensorrt-devel libnccl-devel
ENV PATH=/usr/local/cuda-11.8/bin:$PATH
RUN curl -L "https://github.com/bazelbuild/bazelisk/releases/download/v1.16.0/bazelisk-linux-amd64" -o /usr/local/bin/bazel \
	&& chmod +x /usr/local/bin/bazel \
	&& echo "startup --output_user_root=/tmp/bazel" > /etc/bazel.bazelrc
ENV BAZELISK_HOME=/tmp/bazelisk USER=build 

WORKDIR /build
CMD ["/bin/bash"]
