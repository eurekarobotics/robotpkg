# robotpkg Makefile for:	meta-pkgs/ros2-core
# Created:			Anthony Mallet on Tue,  5 Apr 2022
#

PKGNAME=		ros2-core-${ROS2_VERSION}
ROS2_PKG=		variants
ROS2_VERSION=		0.9.3

CATEGORIES=		meta-pkgs
COMMENT=		The Robotic Operating System 2 - core concepts.

include ../../meta-pkgs/ros2-core/Makefile.common

CONFIGURE_DIRS=		ros_core

include ../../devel/ament-cmake/depend.mk
include ../../devel/ament-cmake-ros/depend.mk
include ../../devel/ros2-rcl/depend.mk
include ../../devel/ros2-rclcpp/depend.mk
include ../../devel/ros2-rclpy/depend.mk
include ../../interfaces/ros2-common-interfaces/depend.mk
include ../../interfaces/ros2-rosidl-defaults/depend.mk
include ../../middleware/sros2/depend.mk
include ../../sysutils/ament-index/depend.mk
include ../../sysutils/ros2-environment/depend.mk
include ../../sysutils/ros2-launch/depend.mk
include ../../sysutils/ros2-launch-ros/depend.mk
include ../../sysutils/ros2cli/depend.mk
include ../../mk/robotpkg.mk
