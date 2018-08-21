# OpenPTrack Docker

OpenPTrack is an open source project to create a scalable, multi-camera solution for person tracking.
It enables many people to be tracked over large areas in real time.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See Installation for notes on how to deploy the project on a live system.

### Prerequisites

Docker, nvidia driver, nvidia-docker are required to be installed before using open_ptrack docker: 

# OpenPTrack Docker

OpenPTrack is an open source project to create a scalable, multi-camera solution for person tracking.
It enables many people to be tracked over large areas in real time.

## Getting Started

The following instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See Installation for notes on how to deploy the project on a live system.

### Prerequisites
Please visit page : https://github.com/OpenPTrack/open_ptrack_v2/wiki/Supported-Hardware

### Installation

Clone the repository:

```
git clone https://github.com/OpenPTrack/open_ptrack_config.git
cd open_ptrack_config
```

If you have not yet installed docker and Nvidia docker 2 and nvidia-384 run :

```
chmod +x setup_host
./setup_host
```

After successfully executing setup_host please reboot your system.
After rebooting your system test nvidia-docker 2 by running

```
sudo docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```

You should see output similar to bellow:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 384.130                Driver Version: 384.130                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 750 Ti  Off  | 00000000:01:00.0  On |                  N/A |
| 40%   31C    P8     1W /  38W |    188MiB /  1998MiB |      1%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

After successfuly executing above command follow the instructions bellow to run single_camera_tracking container or multi_camera_tracking container:

### building open_ptrack images

Next you need to build OpenPtrack images:

This project contains two images : open_ptrack-dep, open_ptrack

Clone the repository: 
```
git clone https://github.com/OpenPTrack/open_ptrack_v2.git
cd open_ptrack_v2/docker/
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

After successfuly executing above command follow the instructions bellow to run single_camera_tracking container or multi_camera_tracking container:

* ### single_camera_tracking 

**Instructions:**

```
cd single_camera_tracking
chmod +x run_single_camera
./run_single_camera
```

* ### multi_camera_tracking 

**Instructions:**

```
cd multi_camera_tracking
```

Edit ros_network.config inside multi_camera_tracking to match your system network configuration and then run:

```
chmod +x run_multi_camera
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

* **Samir Tabriz** - [itabr](https://github.com/itabr/)
