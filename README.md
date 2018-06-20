# open_ptrack_docker

docker folder contains:

- ### itabrz:opengl-opencl
itabrz:opengl-opencl is a base image for itabrz:open_ptrack which enables opencl and opengl with in docker.

- ### itabrz-opt-dep
itabrz-opt-dep is base image for itabrz-open_ptrack and includes all the dependencies requried for open_ptrack. this image is based on nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04, this image contains all the installation process for open_ptrack and it is based on these instructions: [https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit]

**Instrucitons:**
build the image :
```bash
docker build -t itabrz/opt-dep
```

- ### itabrz-open_ptrack
itabrz_open_ptrack is base image for itabrz:open_ptrack-single_camera_tracking and itabrz:open_ptrack-multi_camera_tracking. this image includes open_ptrack installation.

**Instrucitons:**
build the image :
```bash
docker build -t itabrz/open_ptrack
```
or to change a branch
```bash
docker build -t itabrz/open_ptrack --build-arg branch=iss21 .
```

- ### itabrz-open_ptrack-single_camera_tracking 
itabrz-open_ptrack-single_camera_tracking is an image for single camera tracking, although to run single camera tracking it is not neccesserly to use this image, itabrz:open_ptrack itself can run single camera tracking.

**Instrucitons:**
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


- #### itabrz-open_ptrack-multi_camera_tracking 
itabrz-open_ptrack-multi_camera_tracking is an image for multi camera tracking,  this image needs to be built to setup the configurations required for multi camera tracking.

**Instrucitons:**

```bash
xhost +
```
build the image 
MACHINE_TYPE can be either Server or Client :
For master machine :
```bash
docker build --build-arg MACHINE_TYPE="Server" -t open_ptrack-multicamera_camera .```
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

### general information

**open contaier in an other window :**

docker exec  -ti -e DISPLAY ***container-name*** bash


