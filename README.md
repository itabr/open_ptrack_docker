# open_ptrack_docker

docker folder contains:

##### itabrz:opengl-opencl
itabrz:opengl-opencl is a base image for itabrz:open_ptrack which enables opencl and opengl whith in docker, it is based on nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04.

##### itabrz:open_ptrack
itabrz:open_ptrack is base image for itabrz:open_ptrack-single_camera_tracking and itabrz:open_ptrack-multi_camera_tracking. it is based on itabrz:opengl-opencl. this image contains all the installation process for open_ptrack and it is based on these instructions: [https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit](https://docs.google.com/document/d/1iagy-zU1cbV92YQI6EJhieM5-09BGrVsVmmz0QjK0XA/edit)

##### itabrz:open_ptrack-single_camera_tracking 
itabrz:open_ptrack-single_camera_tracking is an image for single camera tracking, although to run single camera tracking it is not neccesserly to use this image, itabrz:open_ptrack itself can run single camera tracking.

##### itabrz:open_ptrack-multi_camera_tracking 
itabrz:open_ptrack-multi_camera_tracking is an image for multi camera tracking, although to run single camera tracking it is not neccesserly to use this image, itabrz:open_ptrack includes all dependecies to run multi camera tracking. this image is used to set up multi camera tracking configurations.