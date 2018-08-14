#!/bin/bash

echo "Pulling docker image ..."
sudo docker pull openptrack/open_ptrack && \
echo "Finished pulling the image." && \
echo "Starting open_ptrack_singlecamera container ..." && \
xhost + && \
sudo docker run \
--runtime=nvidia \
--rm -ti -e DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
--mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
--net=host \
--device /dev/bus/usb:/dev/bus/usb \
--name open_ptrack_singlecamera \
openptrack/open_ptrack bash
