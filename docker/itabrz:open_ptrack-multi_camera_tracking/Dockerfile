# change options according to the machine setup:

# example :

# for Master machine

# docker build \
# --build-arg MASTER_IP_ADDRESS="192.168.100.101" \
# --build-arg MACHINE_IP_ADDRESS="192.168.100.101" \
# --build-arg MACHINE_NAME_ADDRESS="PC1" \
# --build-arg MACHINE_TYPE="Server" \
# -t open_ptrack-multicamera_camera .

# for rest of the nodes :

# docker build \
# --build-arg MASTER_IP_ADDRESS="192.168.100.101" \
# --build-arg MACHINE_IP_ADDRESS="192.168.100.102" \
# --build-arg MACHINE_NAME_ADDRESS="PC2" \
# --build-arg MACHINE_TYPE="Client" \
# -t open_ptrack-multicamera_camera .

# run the container :

# docker run --runtime=nvidia \
# -ti \
# -e DISPLAY \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# --mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/launch/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/opt_calibration/conf/,destination=/root/workspace/ros/src/open_ptrack/opt_calibration/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/detection/cfg/,destination=/root/workspace/ros/src/open_ptrack/detection/cfg/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/cfg/,destination=/root/workspace/ros/src/open_ptrack/tracking/cfg/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
# --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/cfg/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/cfg/ \
# --net=host \
# --device /dev/bus/usb:/dev/bus/usb \
# --name opt-docker-multicamera \
# open_ptrack-multicamera_camera /bin/bash


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
#       roslaunch tracking tracking_node.launch enable_pose:=true enable_object:=true enable_people_tracking:=true
#   Launch each detector specifying the modules to launch:
#       roslaunch detection detection_node_<sensor>.launch enable_pose:=true enable_object:=true enable_people_tracking:=true
#   NOTE: the flags should be the same for both tracker and detection nodes.


FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root

ARG MASTER_IP_ADDRESS=localhost
ENV MASTER_IP=$MASTER_IP_ADDRESS

ARG MACHINE_IP_ADDRESS=localhost
ENV MACHINE_IP=$MACHINE_IP_ADDRESS

ARG MACHINE_NAME_ADDRESS=PC
ENV MACHINE_NAME=$MACHINE_NAME_ADDRESS

ARG MACHINE_TYPE=Server

RUN echo "export ROS_MASTER_URI=http://$MASTER_IP:11311/" >> /root/.bashrc \
    && echo "export ROS_IP=$MACHINE_IP" >> /root/.bashrc \
    && echo "export ROS_PC_NAME=$MACHINE_NAME" >> /root/.bashrc \
    && /bin/bash -c "source /root/.bashrc"

COPY $MACHINE_TYPE/etc/ntp.conf /etc/ntp.conf
