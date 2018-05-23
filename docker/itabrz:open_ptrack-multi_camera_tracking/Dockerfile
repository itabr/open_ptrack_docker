FROM itabrz/open_ptrack
LABEL maintainer "Ilya Tabriz"
WORKDIR /root

ARG MASTER_IP_ADDRESS=localhost
ENV MASTER_IP=$MASTER_IP_ADDRESS

ARG MACHINE_IP_ADDRESS=localhost
ENV MACHINE_IP=$MACHINE_IP_ADDRESS

ARG MACHINE_NAME_ADDRESS=PC
ENV MACHINE_NAME=$MACHINE_NAME_ADDRESS

RUN echo "export ROS_MASTER_URI=http://$MASTER_IP:11311/" >> /root/.bashrc \
    && echo "export ROS_IP=$MACHINE_IP" >> /root/.bashrc \
    && echo "export ROS_PC_NAME=$MACHINE_NAME" >> /root/.bashrc \
    && /bin/bash -c "source /root/.bashrc"