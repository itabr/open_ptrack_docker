FROM itabrz/opengl-opencl
LABEL maintainer "Ilya Tabriz"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections \
    && apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common wget udev apt-utils

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

# section of cook book second
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && apt-get update \
    && apt-get install ros-kinetic-desktop-full python-rosinstall -y \
    && rosdep init \
    && rosdep update

RUN /bin/bash -c "echo 'source /opt/ros/kinetic/setup.bash' >> /root/.bashrc && source /root/.bashrc"

# section of cook book third 
RUN add-apt-repository -y ppa:levi-armstrong/qt-libraries-xenial \
    && add-apt-repository -y ppa:levi-armstrong/ppa \
    && apt-get update \
    && apt-get install -y qt57creator-plugin-ros \
    && grep -rnw "exit 0" /etc/rc.local |cut -f1 -d: | tail -1 | sed -i '$ i echo 0 | tee /proc/sys/kernel/yama/ptrace_scope' /etc/rc.local

# section of cook book forth
# source /opt/ros/kinetic/setup.bash was added because we get error for catkin_make, the error is catkin_make command not found
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
    && cd \
    && mkdir -p workspace/ros/src \
    && cd workspace/ros \
    && catkin_make"

RUN /bin/bash -c "echo 'source /root/workspace/ros/devel/setup.bash' >> /root/.bashrc"

RUN cd ~/workspace/ros \
    && apt-get install -y ocl-icd-opencl-dev \
    && wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda.run \
    && chmod +x cuda.run \
    && ./cuda.run -silent --toolkit \
    && wget "https://www.dropbox.com/s/cx95583vbf1ifzm/cudnn-8.0-linux-x64-v5.1.tgz?dl%3D0&sa=D&ust=1507541105896000&usg=AFQjCNEU511fT00n547PxPt_P6cfSLPVWw" \
    && tar -zxvf cudnn* \
    && cp cuda/include/* /usr/local/cuda/include \
    && cp cuda/lib64/* /usr/local/cuda/lib64/ \
    && echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> ~/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bashrc

# RUN cd \
#     && cd workspace \
#     && git clone https://github.com/openptrack/libfreenect2 \
#     && cd libfreenect2 \
#     && git checkout 1604 \
#     && cd depends/ \
#     && apt-get install -y git cmake cmake-curses-gui libxmu-dev libxi-dev libgl1-mesa-dev dos2unix xorg-dev libglu1-mesa-dev libtool automake libudev-dev libgtk2.0-dev pkg-config libjpeg-turbo8-dev libturbojpeg libglewmx-dev \
#     && ./install_ubuntu.sh \
#     && ln -f -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so \
#     && cd ../examples/protonect/ \
#     && mkdir build && cd build \
#     && /bin/bash -c "source /opt/ros/kinetic/setup.bash\
#     && cmake .. \
#     && make \
#     && make install" \
#     && echo '# ATTR{product}=="Kinect2" \
# SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c4", MODE="0666" \
# SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d8", MODE="0666" \
# SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02d9", MODE="0666"' > ~/90-kinect2.rules \
#     && mv ~/90-kinect2.rules /etc/udev/rules.d/90-kinect2.rules


