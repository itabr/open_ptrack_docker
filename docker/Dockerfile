FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
LABEL maintainer "Ilya Tabriz"

# set up keyboard-configuration and install software-properties-common 
# software-properties-common is needed for apt-add-repository to work
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections \
    && apt-get update && apt-get install -y software-properties-common wget catkin

# section of cook book First
RUN add-apt-repository -y ppa:danielrichter2007/grub-customizer \
    && wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - \
    && apt-get install -y apt-transport-https \
    && echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list \
    && apt-add-repository -y ppa:obsproject/obs-studio \
    && apt-add-repository -y ppa:graphics-drivers/ppa \
    && add-apt-repository -y ppa:yannubuntu/boot-repair \
    && apt-get update \
    && apt-get install -y sublime-text grub-customizer exfat-fuse exfat-utils vim terminator gitg cmake-qt-gui cmake-curses-gui gparted meld cowsay fortune gimp synaptic libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev ncdu filezilla p7zip-full openssh-client openssh-server boot-repair
    # nvidia-384

# section of cook book second
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && apt-get update \
    && apt-get install ros-kinetic-desktop-full python-rosinstall -y \
    && rosdep init \
    && rosdep fix-permissions \
    && rosdep update \
    && echo /bin/bash -c "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
    && /bin/bash -c 'source $HOME/.bashrc'

# section of cook book third 
RUN add-apt-repository -y ppa:levi-armstrong/qt-libraries-xenial \
    && add-apt-repository -y ppa:levi-armstrong/ppa \
    && apt-get update \
    && apt-get install -y qt57creator-plugin-ros \
    && grep -rnw "exit 0" /etc/rc.local |cut -f1 -d: | tail -1 | sed -i '$ i echo 0 | tee /proc/sys/kernel/yama/ptrace_scope' /etc/rc.local

# section of cook book forth
RUN cd \
    && mkdir -p workspace/ros/src \
    && cd workspace/ros \
    && catkin_make \
    && echo /bin/bash -c "source /home/$USER/workspace/ros/devel/setup.bash" >> /home/$USER/.bashrc \
    && apt-get install -y ocl-icd-opencl-dev


# section of cook book sixth section install cuda 8 pass 
# section of cook book seventh cudnn 5.1 pass

# section of cook book eighth
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> ~/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bashrc

# # section of cook book ninth
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
    && cmake .. \
    && make \
    && make install \
    && echo '# ATTR{product}=="Kinect2" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666" \
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"' > ~/90-kinect2.rules \
    && mv ~/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules

# section of cook book tenth
RUN cd /home/$USER/workspace/ros/src \
    && git clone https://github.com/openptrack/iai_kinect2 \
    && cd iai_kinect2 \
    && git checkout 1604

# section of cook book 11th
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

# section of cook book 12th
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
    && printf '#OpenCV\nPKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opencv3/lib/pkgconfig\nexport PKG_CONFIG_PATH\n' >> ~/.bashrc \
    && printf 'PATH=$PATH:/usr/local/opencv3/bin\nexport PATH\n' >> ~/.bashrc  \
    && printf 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/opencv3/lib\nexport LD_LIBRARY_PATH\n' >> ~/.bashrc   \
    && /bin/bash -c 'source $HOME/.bashrc' \
    && ln -s /usr/local/opencv3/share/OpenCV/3rdparty/lib/libippicv.a /usr/local/lib/libippicv.a

# section of cook book 13th
RUN cd ~/workspace/ros/src  \
    && git clone https://bitbucket.org/mcarraro/rtpose_wrapper \
    && cd rtpose_wrapper \
    && git checkout integration-1604 \
    && sudo apt-get --assume-yes install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev \
    && make all -j8
