FROM nvidia/cuda:8.0-devel-ubuntu16.04
LABEL maintainer "Ilya Tabriz"

# set up keyboard-configuration and install software-properties-common 
# software-properties-common is needed for apt-add-repository to work
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections \
    && echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections \
    && apt-get update && apt-get install -y software-properties-common wget

RUN add-apt-repository -y ppa:danielrichter2007/grub-customizer \
    && wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - \
    && apt-get install -y apt-transport-https \
    && echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list \
    && apt-add-repository -y ppa:obsproject/obs-studio \
    && apt-add-repository -y ppa:graphics-drivers/ppa \
    && add-apt-repository -y ppa:yannubuntu/boot-repair \
    && apt-get update \
    && apt-get install -y sublime-text \
    grub-customizer \
    exfat-fuse \
    exfat-utils \
    vim \
    terminator \
    gitg \
    cmake-qt-gui \
    cmake-curses-gui \
    gparted \
    meld \
    cowsay \
    fortune \
    gimp \
    synaptic \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    ncdu \
    filezilla \
    p7zip-full \
    openssh-client \
    openssh-server \
    boot-repair \
    nvidia-384

# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
#     && apt-get update \
#     && apt-get install ros-kinetic-desktop-full python-rosinstall -y \
#     && rosdep init \
#     && rosdep update \
#     && echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
#     && source ~/.bashrc
