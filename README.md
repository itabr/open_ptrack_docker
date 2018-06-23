# OpenPTrack docker

OpenPTrack is an open source project to create a scalable, multi-camera solution for person tracking.
It enables many people to be tracked over large areas in real time.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Docker and nvidia-docker are required to be installed before using open_ptrack docker: 

#### Install Docker

for updated version look at the Docker official instructions

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

DOCKER_EE_URL="https://download.docker.com/linux"
curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

apt-cache madison docker-ce
```
##### Now test docker with hello-world image
```
sudo docker run hello-world
```


#### Install nvidia-docker 2 

for updated version look at the Nvidia Docker official instructions

```
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0/nvidia-docker_1.0.0-1_amd64.deb

sudo dpkg -i nvidia-docker*.deb
sudo -b nohup nvidia-docker-plugin > /tmp/nvidia-docker.log
```

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
##### Test nvidia-smi with the latest official CUDA image
```
sudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```


### Installing

Next you need to build OpenPtrack images:

This project contains four different images : itabrz-opt-dep, itabrz-open_ptrack, itabrz-open_ptrack-single_camera_tracking, itabrz-open_ptrack-multi_camera_tracking


- ### itabrz-opt-dep
itabrz-opt-dep is base image for itabrz-open_ptrack and includes all the dependencies requried for open_ptrack. this image is based on nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04, this image contains all the installation process for open_ptrack and it is based on these instructions: [https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit]

**Instructions:**
build the image :
```bash
docker build -t itabrz/opt-dep .
```

- ### itabrz-open_ptrack
itabrz_open_ptrack is base image for itabrz:open_ptrack-single_camera_tracking and itabrz:open_ptrack-multi_camera_tracking. this image includes open_ptrack installation.

**Instructions:**
build the image :
```bash
docker build -t itabrz/open_ptrack .
```
or to change a branch
```bash
docker build -t itabrz/open_ptrack --build-arg branch=iss21 .
```

- ### itabrz-open_ptrack-single_camera_tracking 
itabrz-open_ptrack-single_camera_tracking is an image for single camera tracking, although to run single camera tracking it is not neccesserly to use this image, itabrz:open_ptrack itself can run single camera tracking.

**Instructions:**
```bash
xhost +
```
build the image :
```bash
docker build -t itabrz/open_ptrack-single_camera_tracking .
```
in the same folder run the container 
```bash
docker run --runtime=nvidia \
--rm -ti -e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
--net=host \
--device /dev/bus/usb:/dev/bus/usb \
--name opt-docker-singlecamera itabrz/open_ptrack-single_camera_tracking bash
```


- ### itabrz-open_ptrack-multi_camera_tracking 
itabrz-open_ptrack-multi_camera_tracking is an image for multi camera tracking,  this image needs to be built to setup the configurations required for multi camera tracking.

**Instructions:**

```bash
xhost +
```
build the image 
MACHINE_TYPE can be either Server or Client :
For master machine :
```bash
docker build --build-arg MACHINE_TYPE="Server" -t open_ptrack-multicamera_camera .
```
For other nodes :
```bash
 docker build --build-arg MACHINE_TYPE="Client" -t open_ptrack-multicamera_camera .
```
in the same folder run the container, you need to change the ROS_MASTER_URI and 
ROS_IP, ROS_PC_NAME per machine :
```bash
docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
--mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/launch/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/conf/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
--net=host --device /dev/bus/usb:/dev/bus/usb \
--name opt-docker-multicamera \
-e "ROS_MASTER_URI=http://192.168.100.101:11311/" \
-e "ROS_IP=192.168.100.101" \
-e "ROS_PC_NAME=PC1" \
open_ptrack-multicamera_camera bash
```



## Deployment

you can use bellow command to Run a command in a running container:
```
docker exec  -ti -e DISPLAY ***container-name*** bash
```


## Built With

* [Docker](https://www.docker.com/) - Container platform provider
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) - NVIDIA container runtime for Docker


## Authors

* **Samir Tabriz** - *Initial work* - [itabr](https://github.com/itabr/)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.
