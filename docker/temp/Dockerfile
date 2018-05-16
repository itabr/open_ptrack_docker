FROM itabrz/opengl-opencl
LABEL maintainer "Ilya Tabriz"
WORKDIR /root/opt

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