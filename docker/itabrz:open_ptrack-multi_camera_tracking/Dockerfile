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


# docker build -t ilya/opt-docker \
# --build-arg MASTER_IP_ADDRESS="192.168.100.101" \
# --build-arg MACHINE_IP_ADDRESS="192.168.100.103" \
# --build-arg MACHINE_NAME_ADDRESS="PC3"\
# --build-arg MACHINE_TYPE="Client" .

# docker run --runtime=nvidia -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host --device /dev/bus/usb:/dev/bus/usb ilya/opt-docker

# roslaunch detection detection_node_kinect_03.launch enable_pose:=true enable_object:=true enable_people_tracking:=true
