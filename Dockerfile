FROM ghcr.io/tiiuae/fog-ros-baseimage-builder:v2.1.0 

COPY . /main_ws/src

WORKDIR /main_ws/src

RUN ./install_gz.sh

WORKDIR /main_ws

RUN apt update 

RUN rosdep install -r --from-paths src -i -y --rosdistro humble
RUN apt install -y ros-humble-actuator-msgs

COPY build.sh /main_ws/build.sh
RUN build.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh