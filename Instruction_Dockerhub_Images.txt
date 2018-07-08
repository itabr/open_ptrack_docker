# OpenPTrack Docker

OpenPTrack is an open source project to create a scalable, multi-camera solution for person tracking.
It enables many people to be tracked over large areas in real time.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See Installation for notes on how to deploy the project on a live system.

### Prerequisites

Docker, nvidia driver, nvidia-docker are required to be installed before using open_ptrack docker: 

#### Install Docker

For an updated version look at the Docker official instructions [here](https://docs.docker.com/install/)

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

##### Reboot your system 

##### Test nvidia-smi with the latest official CUDA image
```
sudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```

### Installing

Next you need to clone the open_ptrack_docker and then run single_camera_tracking or multi_camera_tracking:

Clone the repository: 
```
git clone https://github.com/itabr/open_ptrack_docker.git
cd open_ptrack_docker
```

** open_ptrack-single_camera_tracking **
open_ptrack-single_camera_tracking is an image for single camera tracking, although to run single camera tracking it is not neccessery to use this image, open_ptrack itself can run single camera tracking.

**Instructions:**
```bash

cd open_ptrack-single_camera_tracking

xhost +

sudo docker run --runtime=nvidia \
--rm -ti -e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
--net=host \
--device /dev/bus/usb:/dev/bus/usb \
--name opt-docker-singlecamera openptrack/open_ptrack-single_camera_tracking bash
```

** open_ptrack-multi_camera_tracking **
open_ptrack-multi_camera_tracking is an image for multi camera tracking,  this image needs to be built to set up the configurations required for multi camera tracking.

**Instructions:**

Build the image for open_ptrack-multi_camera_tracking

Valid value for MACHINE_TYPE is Server or Client :

For master machine :
```bash
cd open_ptrack-multi_camera_tracking
xhost +
sudo docker build --build-arg MACHINE_TYPE="Server" -t openptrack/open_ptrack-multicamera_camera .
```
For other nodes :
```bash
sudo docker build --build-arg MACHINE_TYPE="Client" -t openptrack/open_ptrack-multicamera_camera .
```
Note : dot (.) is part of the command. It means the current directory.

In the same folder run the container, you need to change the ROS_MASTER_URI and 
ROS_IP, ROS_PC_NAME according to your configuration :

Example:

```bash
sudo docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
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
openptrack/open_ptrack-multicamera_camera bash
```

After this step follow Time-Synchronization on the wiki [here](https://github.com/OpenPTrack/open_ptrack/wiki/Time-Synchronization) and then continue with the calibration

## Deployment

You can use below command to create a new terminal for a running container. This can be used during calibration and multi camera tracking:
```
docker exec  -ti -e DISPLAY container-name bash
```

## Built With

* [Docker](https://www.docker.com/) - Container platform provider
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) - NVIDIA container runtime for Docker

## Authors

* **Samir Tabriz** - *Initial work* - [itabr](https://github.com/itabr/)