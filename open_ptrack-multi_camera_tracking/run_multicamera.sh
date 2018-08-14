#!/bin/bash

export ROS_MASTER_URI="http://192.168.100.101:11311/"
export ROS_IP="192.168.100.101"
export ROS_PC_NAME="PC1"
export MACHINE_TYPE="Server"

echo "Pulling docker image ..."
sudo docker pull openptrack/open_ptrack && \
echo "Finished pulling the image." && \
echo "Starting open_ptrack_multicamera container ..." && \
xhost + && \
sudo docker run \
--runtime=nvidia \
--rm \
-ti \
-e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $(pwd)/open_ptrack_config/$MACHINE_TYPE/etc/ntp.conf/:/etc/ntp.conf \
--mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/launch/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/conf/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
--net=host \
--device /dev/bus/usb:/dev/bus/usb \
--name open_ptrack_multicamera \
--env ROS_MASTER_URI \
--env ROS_IP \
--env ROS_PC_NAME \
openptrack/open_ptrack bash