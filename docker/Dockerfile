FROM itabrz/open_ptrack_ros
LABEL maintainer "Ilya Tabriz"

RUN cd \
    && cd workspace \
    && git clone https://github.com/openptrack/libfreenect2 \
    && cd libfreenect2 \
    && git checkout 1604 \
    && cd depends/ \
    && apt-get install -y git cmake cmake-curses-gui libxmu-dev libxi-dev libgl1-mesa-dev dos2unix xorg-dev libglu1-mesa-dev libtool automake libudev-dev libgtk2.0-dev pkg-config libjpeg-turbo8-dev libturbojpeg libglewmx-dev \
    && ./install_ubuntu.sh \
    && ln -f -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so \
    && cd ../examples/protonect/ \
    && mkdir build && cd build \
    && /bin/bash -c "source /opt/ros/kinetic/setup.bash\
    && cmake .. \
    && make \
    && make install" \
    && echo '# ATTR{product}=="Kinect2" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"' > ~/90-kinect2.rules \
    && mv ~/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules

RUN cd ~/workspace/ros/src \
    && git clone https://github.com/openptrack/iai_kinect2 \
    && cd iai_kinect2 \
    && git checkout 1604

RUN apt-get install cmake libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev -y --force-yes \
    && mkdir /tmp/ceres_install \
    && cd /tmp/ceres_install \
    && git clone https://ceres-solver.googlesource.com/ceres-solver \
    && cd ceres-solver \
    && git fetch --tags \
    && git checkout tags/1.9.0 \
    && cd .. \
    && mkdir ceres-bin \
    && cd ceres-bin \
    && cmake ../ceres-solver \
    && make -j8 \
    && make test \
    && make install \
    && rm -R /tmp/ceres_install \
    && cd ~/workspace/ros/src \
    && git clone https://github.com/iaslab-unipd/calibration_toolkit \
    && cd calibration_toolkit \
    && git fetch origin --tags \
    && git checkout tags/v0.2

RUN cd \
    && cd workspace \
    && apt-get update \
    && git clone https://github.com/marketto89/opencv \
    && cd opencv \
    && git checkout 3.1.0-with-cuda8 \
    && mkdir release \
    && cd release \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local/opencv3 -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -D WITH_IPP=ON -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs .. \
    && make -j8 -l8 \
    && make install \
    && printf '#OpenCV\nPKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opencv3/lib/pkgconfig\nexport PKG_CONFIG_PATH\n' >> /root/.bashrc \
    && printf 'PATH=$PATH:/usr/local/opencv3/bin\nexport PATH\n' >> /root/.bashrc  \
    && printf 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/opencv3/lib\nexport LD_LIBRARY_PATH\n' >> /root/.bashrc   \
    && /bin/bash -c "source /root/.bashrc" \
    && ln -s /usr/local/opencv3/share/OpenCV/3rdparty/lib/libippicv.a /usr/local/lib/libippicv.a

RUN cd ~/workspace/ros/src  \
    && git clone https://bitbucket.org/mcarraro/rtpose_wrapper \
    && cd rtpose_wrapper \
    && git checkout integration-1604 \
    && apt-get --assume-yes install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev \
    && make all -j8

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
    && cd ~/workspace/ros/src \
    && git clone https://github.com/openptrack/open_ptrack_v2 open_ptrack \
    && cd open_ptrack \
    && apt-get install -y ros-kinetic-qt-build qml-module-qtquick-controls \
    && source /root/.bashrc \
    && cd ../..  \
    && catkin_make"

RUN /bin/bash -c "source /root/workspace/ros/devel/setup.bash \
    && roscd yolo_detector/darknet_opt \
    && wget https://pjreddie.com/media/files/yolo.weights"

RUN ln -s  /root/workspace/ros/src/open_ptrack /root/open_ptrack 

# configure ntp
RUN apt-get install ntp -y