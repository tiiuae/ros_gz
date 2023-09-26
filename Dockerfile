FROM ghcr.io/tiiuae/fog-ros-baseimage-builder:v2.1.0 

# This repository has multiple ros2 packages inside, Hence building it in a single stage container
# as opposed to using /packagin/build.sh

COPY . /main_ws/src
WORKDIR /main_ws/src

# The ros_gz bridge needs to be compiled with the right version of gazebosim installed and sourced.
# When gazebosim version changes, we need to modify this file
RUN ./install_gz.sh

WORKDIR /main_ws

# Install the pacakges dependencies
RUN apt update 
RUN rosdep install -r --from-paths src -i -y --rosdistro humble

# this dependency gets missed out even thoug it is present in package.xml
RUN apt install -y ros-humble-actuator-msgs

COPY build.sh /main_ws/build.sh
RUN build.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh