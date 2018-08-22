#!/bin/bash

container_name="open_ptrack_multi_camera"
if [ $# -eq 0 ]; then
    if [ "$(sudo docker ps -a | grep $container_name)" ]; then

        if [ ! "$(sudo docker inspect -f {{.State.Running}} $container_name)" ]; then
            printf "$container_name container is already running.\nRunning a new command in $container_name. \n" && \
            xhost + && \
            sudo docker exec  -ti -e DISPLAY $container_name bash
        else
            printf "$container_name container exist.\nStarting $container_name container. \n" && \
            xhost + && \
            sudo docker start $container_name && \
            sudo docker exec  -ti -e DISPLAY $container_name bash
        fi

    else

        printf "$container_name container does not exist.\nRunning a new $container_name container. \n" && \
        printf "Loading ROS network configuration\n" && \
        export $(cat ros_network.env | xargs)
        if [[ $ROS_MASTER_URI = *$ROS_IP* ]]; then
                    export MACHINE_TYPE="master" && \
                    printf "This machine is recognized as master.\n"
        else
                    export MACHINE_TYPE="slave" && \
                    printf "This machine is recognized as slave.\n"
        fi

        printf "Starting $container_name container.\n" && \
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
            --env-file ros_network.env \
            --name $container_name \
            openptrack/open_ptrack bash     
    fi

else
    while getopts ":rs" opt; do
        case ${opt} in
            r ) 
                if [ "$(sudo docker ps -a | grep $container_name)" ]; then
                    printf "removing $container_name\n"
                    sudo docker stop $container_name
                    sudo docker rm $container_name
                fi
            ;;
            s )
                if [ "$(sudo docker ps -a | grep $container_name)" ]; then
                    printf "stoping $container_name\n"
                    sudo docker stop $container_name
                fi
            ;;
            \? ) printf "Usage: ./run_multicamera.sh [-r -s]\n-r remove \n-s stop"
            ;;
        esac
    done
fi