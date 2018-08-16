#!/bin/bash

container_name="open_ptrack_multi_camera"
if [ $# -eq 0 ]; then
    if [ "$(docker ps -a | grep $container_name)" ]; then

        if [ ! "$(docker inspect -f {{.State.Running}} $container_name)" ]; then
            printf "$container_name container is already running.\nRunning a new command in $container_name. \n" && \
            xhost + && \
            docker exec  -ti -e DISPLAY $container_name bash
        else
            printf "$container_name container exist.\nStarting $container_name container. \n" && \
            xhost + && \
            docker start $container_name && \
            docker exec  -ti -e DISPLAY $container_name bash
        fi

    else

        printf "$container_name container does not exist.\nRunning a new $container_name container. \n" && \
        printf "Loading ROS network configuration\n" && \

        SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && \
        . $SCRIPTDIR/ros_network.config;

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
            --name $container_name \
            --env ROS_MASTER_URI \
            --env ROS_IP \
            --env ROS_PC_NAME \
            openptrack/open_ptrack bash     
    fi

else
    while getopts ":r" opt; do
        case ${opt} in
            r ) 
                if [ "$(docker ps -a | grep $container_name)" ]; then
                    printf "removing $container_name\n"
                    docker stop $container_name
                    docker rm $container_name
                fi
            ;;
            \? ) printf "Usage: ./run_multicamera.sh [-r]"
            ;;
        esac
    done
fi