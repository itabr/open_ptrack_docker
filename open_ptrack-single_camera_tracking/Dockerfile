# xhost +
# docker build -t open_ptrack/open_ptrack-single_camera_tracking .

# run the container :

# option 1 :
# start the contianer: 
# docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ --mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ --net=host --device /dev/bus/usb:/dev/bus/usb --name opt-docker-singlecamera open_ptrack/open_ptrack-single_camera_tracking /bin/bash

# option 2 (requires absolute path for launch files):

# uncomment line 31 - 60
# again run : docker build -t open_ptrack/open_ptrack-single_camera_tracking .
# start the contianer: 
# docker run --runtime=nvidia --rm -ti -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --mount type=bind,source=$(pwd)/open_ptrack_config,target=/root/open_ptrack_config --net=host --device /dev/bus/usb:/dev/bus/usb --name opt-singlecamera open_ptrack/open_ptrack-single_camera_tracking /bin/bash

# to open new terminal window for container run : 
# docker exec  -ti -e DISPLAY opt-singlecamera bash

# run tracking for single camera
# <all modules activated>
# roslaunch tracking single_camera_tracking_node.launch

# <same result as the one above, but specifying the modules (you can also disable them with false)>
# roslaunch tracking single_camera_tracking_node.launch enable_pose:=false enable_people_tracking:=true enable_object:=true

FROM open_ptrack/open_ptrack
LABEL maintainer "Samir Tabriz"
WORKDIR /root
