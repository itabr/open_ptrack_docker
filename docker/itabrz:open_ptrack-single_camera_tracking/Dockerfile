# run tracking for single camera
# <all modules activated>
# roslaunch tracking single_camera_tracking_node.launch

# <same result as the one above, but specifying the modules (you can also disable them with false)>
# roslaunch tracking single_camera_tracking_node.launch enable_pose:=true enable_people_tracking:=true enable_object:=true

# docker build -t open_ptrack_single_camera .
# docker run --runtime=nvidia -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host --device /dev/bus/usb:/dev/bus/usb itabrz/open_ptrack-single_camera_tracking

FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root