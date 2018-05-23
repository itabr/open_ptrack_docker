# roslaunch tracking single_camera_tracking_node.launch - runs tracking for single camera

# docker build -t open_ptrack_single_camera .
# docker run --runtime=nvidia -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host --device /dev/bus/usb:/dev/bus/usb open_ptrack_single_camera

FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root
CMD roslaunch tracking single_camera_tracking_node.launch