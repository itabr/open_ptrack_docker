#!/bin/bash

container_name="open_ptrack_single_camera"

if [ $# -eq 0 ];
then
    if [ "$(docker ps -a | grep $container_name)" ]; then
        if [ "$(docker inspect -f {{.State.Running}} $container_name)" ]; then
            echo "open_ptrack_single_camera container is already running. \n Running a new command in open_ptrack_single_camera." && \
            xhost + && \
            docker exec  -ti -e DISPLAY $container_name bash
        else
            echo "open_ptrack_single_camera container exist.\n Starting open_ptrack_single_camera container ..." && \
            xhost + && \
            docker start $container_name && \
            docker exec  -ti -e DISPLAY $container_name bash
        fi
    else
        echo "open_ptrack_single_camera container does not exist, running a new open_ptrack_single_camera container ..." && \
        xhost + && \
        sudo docker run \
            --runtime=nvidia \
            --rm \
            -ti \
            -e DISPLAY \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            --mount type=bind,source=$(pwd)/open_ptrack_config/detection/launch/,destination=/root/workspace/ros/src/open_ptrack/detection/launch/ \
            --mount type=bind,source=$(pwd)/open_ptrack_config/detection/conf/,destination=/root/workspace/ros/src/open_ptrack/detection/conf/ \
            --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/launch/,destination=/root/workspace/ros/src/open_ptrack/tracking/launch/ \
            --mount type=bind,source=$(pwd)/open_ptrack_config/tracking/conf/,destination=/root/workspace/ros/src/open_ptrack/tracking/conf/ \
            --mount type=bind,source=$(pwd)/open_ptrack_config/yolo_detector/launch/,destination=/root/workspace/ros/src/open_ptrack/yolo_detector/launch/ \
            --net=host \
            --device /dev/bus/usb:/dev/bus/usb \
            --name open_ptrack_single_camera \
            openptrack/open_ptrack bash
    fi
else
    while getopts ":r" opt; do
        case ${opt} in
            r ) 
                if [ "$(docker ps -a | grep $container_name)" ]; then
                    echo "removing $container_name"
                    docker rm $container_name
                fi
            ;;
            \? ) echo "Usage: ./run_singlecamera.sh [-r]"
            ;;
        esac
    done
fi