#!/bin/bash

source /opt/ros/humble/setup.bash
source /main_ws/install/setup.bash

export GZ_VERSION=garden
export GZ_PARTITION=sim

ros2 run ros_gz_bridge parameter_bridge /clock@rosgraph_msgs/msg/Clock[ignition.msgs.Clock
