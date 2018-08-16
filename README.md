# OpenPTrack Docker

OpenPTrack is an open source project to create a scalable, multi-camera solution for person tracking.
It enables many people to be tracked over large areas in real time.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See Installation for notes on how to deploy the project on a live system.

### Prerequisites

Docker, nvidia driver, nvidia-docker are required to be installed before using open_ptrack docker: 

#### Install Docker

For updated version look at the Docker official instructions [here](https://docs.docker.com/install/)

```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

```
##### Now test docker with hello-world image
```
sudo docker run hello-world
```
#### Install nvidia driver

```
sudo apt-get update
sudo apt-get install nvidia-384
```

#### Install nvidia-docker 2 

For updated version look at the Nvidia Docker official instructions [here](https://github.com/NVIDIA/nvidia-docker)

##### If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
```
sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker
```

##### Add the package repositories
```
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
```
##### Install nvidia-docker2 and reload the Docker daemon configuration
```
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

##### reboot your system 

##### Test nvidia-smi with the latest official CUDA image
```
sudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```

### Installing

Next you need to build OpenPtrack images:

This project contains four different images : open_ptrack-dep, open_ptrack, open_ptrack-single_camera_tracking, open_ptrack-multi_camera_tracking

Clone the repository: 
```
git clone https://github.com/itabr/open_ptrack_docker.git
cd open_ptrack_docker
```

* ### open_ptrack-dep
open_ptrack-dep is base image for open_ptrack and includes all the dependencies requried for open_ptrack. this image is based on nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04, this image contains all the installation process for open_ptrack and it is based on the instructions [here](https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit)

**Instructions:**
Build the image :
```bash
cd open_ptrack-dep
sudo docker build -t openptrack/open_ptrack-dep .
```

Note : dot (.) is part of the command. It means the current directory.

* ### open_ptrack
open_ptrack is based on open_ptrack-dep and it is the base image for open_ptrack-single_camera_tracking and open_ptrack-multi_camera_tracking. this image includes open_ptrack installation.

**Instructions:**
Build the image :
```bash
cd open_ptrack
sudo docker build -t openptrack/open_ptrack .
```
or to change a branch
```bash
cd open_ptrack
sudo docker build -t openptrack/open_ptrack --build-arg branch=iss21 .
```

Note : dot (.) is part of the command. It means the current directory.

* ### open_ptrack-single_camera_tracking 
open_ptrack-single_camera_tracking is an image for single camera tracking, although to run single camera tracking it is not neccesserly to use this image, open_ptrack itself can run single camera tracking.

**Instructions:**

```
cd single_camera_tracking
./run_single_camera
```


* ### open_ptrack-multi_camera_tracking 
open_ptrack-multi_camera_tracking is an image for multi camera tracking,  this image needs to be built to setup the configurations required for multi camera tracking.

**Instructions:**

```
cd multi_camera_tracking
```

Edit ros_network.config inside multi_camera_tracking to match your system network configuration and then run:

```
./run_multi_camera
```

After this step follow Time-Synchronization on the wiki [here](https://github.com/OpenPTrack/open_ptrack/wiki/Time-Synchronization) and then continue with the calibration

## Deployment

You can use bellow command to Run a command in a running container:
```
docker exec  -ti -e DISPLAY container-name bash
```

## Built With

* [Docker](https://www.docker.com/) - Container platform provider
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) - NVIDIA container runtime for Docker

## Authors

* **Samir Tabriz** - *Initial work* - [itabr](https://github.com/itabr/)