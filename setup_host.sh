#!/bin/bash
# Install nvidia-384
echo "Installing nvidia-384" && \
sudo apt-get update && \
sudo apt-get install -y nvidia-384 && \
echo "Successfully installed nvidia-384" && \
# Install Docker
echo "Installing Docker" && \
sudo apt-get update && \
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo apt-key fingerprint 0EBFCD88 && \
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
sudo apt-get update && \
sudo apt-get install docker-ce && \
echo "Successfully installed Docker" && \
# Testing Docker
echo "Testing Docker" && \
sudo docker run hello-world && \
echo "Successfully tested Docker" && \
# Installing nvidia-docker 2
echo "Installing nvidia-docker 2" && \
echo "Adding the package repositories" && \
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
sudo tee /etc/apt/sources.list.d/nvidia-docker.list && \
sudo apt-get update && \
echo "Installing nvidia-docker 2 and reload the Docker daemon configuration" && \
sudo apt-get install -y nvidia-docker2 && \
sudo pkill -SIGHUP dockerd && \
echo "Please reboot your system and test nvidia-docker2 by using:\nsudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi"