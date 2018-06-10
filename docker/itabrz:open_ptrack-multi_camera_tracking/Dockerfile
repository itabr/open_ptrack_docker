# change options according to the machine setup:

# example :

# for Master machine

# docker build \
# --build-arg MACHINE_TYPE="Server" \
# -t open_ptrack-multicamera_camera .

# for rest of the nodes :

# docker build \
# --build-arg MACHINE_TYPE="Client" \
# -t open_ptrack-multicamera_camera .

# run the container :

# docker run --runtime=nvidia \
# --rm \
# -ti \
# -e DISPLAY \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# --mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/launch/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/conf/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
# --net=host \
# --device /dev/bus/usb:/dev/bus/usb \
# --name opt-docker-multicamera \
# -e "ROS_MASTER_URI=http://192.168.100.101:11311/" \
# -e "ROS_IP=192.168.100.102" \
# -e "ROS_PC_NAME=PC2" \
# open_ptrack-multicamera_camera /bin/bash


# docker run --runtime=nvidia \
# -ti \
# --rm \
# -e DISPLAY \
# -e "ROS_MASTER_URI=http://192.168.100.101:11311/" \
# -e "ROS_IP=192.168.100.102" \
# -e "ROS_PC_NAME=PC2" \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# --net=host \
# --device /dev/bus/usb:/dev/bus/usb \
# --name opt-docker-multicamera \
# open_ptrack-multicamera_camera /bin/bash

# docker run --runtime=nvidia \
# -ti \
# --rm \
# -e DISPLAY \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v open_ptrack_config:/root/optConfig \
# --net=host \
# --device /dev/bus/usb:/dev/bus/usb \
# --name opt-docker-multicamera1 \
# open_ptrack-multicamera_camera /bin/bash


# open contaier in an other window :

# docker exec  -ti -e DISPLAY opt-docker-multicamera bash

# <end-users procedure>
#   <edit camera_network.yaml paying attention to specify the enable flags>
#   <configure and launch everything as OpenPTrack v1.0>
#   <if you want to disable/enable other features>
#   <re-edit camera_network.yaml>
#   <re-do the calibration_initializer.launch phase (just that one is needed!) >	
#   <you are ready to launch everything>
#   <more advanced procedure>
#   <follow end-users procedure>
#   Launch tracker specifying the modules to launch:
#       roslaunch tracking tracking_node.launch enable_pose:=false enable_object:=true enable_people_tracking:=true
#   Launch each detector specifying the modules to launch:
#       roslaunch detection detection_node_<sensor>.launch enable_pose:=true enable_object:=true enable_people_tracking:=true
#   NOTE: the flags should be the same for both tracker and detection nodes.


FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root

ENV ROS_MASTER_URI = http://192.168.100.101:11311/
ENV ROS_IP = 192.168.100.101
ENV ROS_PC_NAME = PC1

ARG MACHINE_TYPE=Server

COPY $MACHINE_TYPE/etc/ntp.conf /etc/ntp.conf


RUN mkdir /root/open_ptrack_config \
    && cd /root/open_ptrack_config \
    && mkdir opt_calibration \
    && cd opt_calibration/ \
    && mkdir launch conf \
    && cd .. \
    && mkdir detection \
    && cd detection/ \
    && mkdir conf launch \
    && cd .. \
    && mkdir tracking \
    && cd tracking/ \
    && mkdir conf launch \
    && cd .. \
    && mkdir yolo_detector \
    && cd yolo_detector/ \
    && mkdir launch \
    && cd .. \
    && cp -r /root/workspace/ros/src/open_ptrack/opt_calibration/launch/* opt_calibration/launch \
    && cp -r /root/workspace/ros/src/open_ptrack/opt_calibration/conf/* opt_calibration/conf \
    && cp -r /root/workspace/ros/src/open_ptrack/detection/conf/* detection/conf \
    && cp -r /root/workspace/ros/src/open_ptrack/detection/launch/* detection/launch \
    && cp -r /root/workspace/ros/src/open_ptrack/tracking/launch/* tracking/launch \
    && cp -r /root/workspace/ros/src/open_ptrack/tracking/conf/* tracking/conf  \
    && cp -r /root/workspace/ros/src/open_ptrack/yolo_detector/launch/* yolo_detector/launch

RUN rm -rf /root/workspace/ros/src/open_ptrack/opt_calibration/launch \
    && ln /root/open_ptrack_config/opt_calibration/launch/* /root/workspace/ros/src/open_ptrack/opt_calibration/launch/* \
    && rm -rf /root/workspace/ros/src/open_ptrack/opt_calibration/conf \
    && ln /root/open_ptrack_config/opt_calibration/conf/* /root/workspace/ros/src/open_ptrack/opt_calibration/conf/* \    
    && rm -rf /root/workspace/ros/src/open_ptrack/detection/conf \
    && ln /root/open_ptrack_config/detection/conf/* /root/workspace/ros/src/open_ptrack/detection/conf/* \
    && rm -rf /root/workspace/ros/src/open_ptrack/detection/launch \
    && ln /root/open_ptrack_config/detection/launch/* /root/workspace/ros/src/open_ptrack/detection/launch/* \
    && rm -rf /root/workspace/ros/src/open_ptrack/tracking/launch \
    && ln /root/open_ptrack_config/tracking/launch/* /root/workspace/ros/src/open_ptrack/tracking/launch/* \
    && rm -rf /root/workspace/ros/src/open_ptrack/tracking/conf \
    && ln /root/open_ptrack_config/tracking/conf/* /root/workspace/ros/src/open_ptrack/tracking/conf/* \
    && rm -rf /root/workspace/ros/src/open_ptrack/yolo_detector/launch \
    && ln /root/open_ptrack_config/yolo_detector/launch/* /root/workspace/ros/src/open_ptrack/yolo_detector/launch/*

