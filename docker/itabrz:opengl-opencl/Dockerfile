FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

LABEL maintainer "itabrz@gmail.com"

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display,compute,utility

RUN apt-get update && apt-get install -y --no-install-recommends \
        mesa-utils && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends         ocl-icd-libopencl1         clinfo &&     rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/OpenCL/vendors &&     echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

ENV NVIDIA_VISIBLE_DEVICES=all

CMD ["clinfo"]
