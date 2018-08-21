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
git clone https://github.com/OpenPTrack/open_ptrack_docker_config.git
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

#### single_camera_tracking:

```
cd single_camera_tracking
chmod +x run_single_camera
./run_single_camera
```

Usage: ./run_singlecamera.sh [-r -s]
-r remove container 
-s stop container

#### multi_camera_tracking:
```
cd multi_camera_tracking
```

Edit ros_network.config inside multi_camera_tracking to match your system network configuration and then run:

```
chmod +x run_multi_camera
./run_multi_camera
```

Usage: ./run_multicamera.sh [-r -s]
-r remove container
-s stop container

After this step follow Time-Synchronization on the wiki [here](https://github.com/OpenPTrack/open_ptrack/wiki/Time-Synchronization) and then continue with the calibration

## Built With

* [Docker](https://www.docker.com/) - Container platform provider
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) - NVIDIA container runtime for Docker

## Authors

* **Samir Tabriz** - [itabr](https://github.com/itabr/)
