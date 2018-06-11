# xhost +
# docker build -t itabrz/open_ptrack-single_camera_tracking .

# run the container :

# docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ --mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ --net=host --device /dev/bus/usb:/dev/bus/usb --name opt-docker-singlecamera itabrz/open_ptrack-single_camera_tracking /bin/bash




# docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host --device /dev/bus/usb:/dev/bus/usb --name opt-singlecamera itabrz/open_ptrack /bin/bash

# openning new terminal

# docker exec  -ti -e DISPLAY opt-singlecamera bash


# run tracking for single camera
# <all modules activated>
# roslaunch tracking single_camera_tracking_node.launch

# <same result as the one above, but specifying the modules (you can also disable them with false)>
# roslaunch tracking single_camera_tracking_node.launch enable_pose:=true enable_people_tracking:=true enable_object:=true

FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root

RUN mkdir /root/open_ptrack_config \
    && cd /root/open_ptrack_config \
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
    && cp -r /root/workspace/ros/src/open_ptrack/detection/conf/* detection/conf \
    && cp -r /root/workspace/ros/src/open_ptrack/detection/launch/* detection/launch \
    && cp -r /root/workspace/ros/src/open_ptrack/tracking/launch/* tracking/launch \
    && cp -r /root/workspace/ros/src/open_ptrack/tracking/conf/* tracking/conf  \
    && cp -r /root/workspace/ros/src/open_ptrack/yolo_detector/launch/* yolo_detector/launch

RUN rm -rf /root/workspace/ros/src/open_ptrack/detection/conf \
    && ln -s /root/open_ptrack_config/detection/conf /root/workspace/ros/src/open_ptrack/detection/conf \
    && rm -rf /root/workspace/ros/src/open_ptrack/detection/launch \
    && ln -s /root/open_ptrack_config/detection/launch /root/workspace/ros/src/open_ptrack/detection/launch \
    && rm -rf /root/workspace/ros/src/open_ptrack/tracking/launch \
    && ln -s /root/open_ptrack_config/tracking/launch /root/workspace/ros/src/open_ptrack/tracking/launch \
    && rm -rf /root/workspace/ros/src/open_ptrack/tracking/conf \
    && ln -s /root/open_ptrack_config/tracking/conf /root/workspace/ros/src/open_ptrack/tracking/conf \
    && rm -rf /root/workspace/ros/src/open_ptrack/yolo_detector/launch \
    && ln -s /root/open_ptrack_config/yolo_detector/launch /root/workspace/ros/src/open_ptrack/yolo_detector/launch