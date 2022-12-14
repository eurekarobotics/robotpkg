# robotpkg depend.mk for:	path/hpp-manipulation-urdf
# Created:			Florent Lamiraux on Sat, 7 Mar 2015
#

DEPEND_DEPTH:=				${DEPEND_DEPTH}+
HPPMANIPULATIONURDF_DEPEND_MK:=		${HPPMANIPULATIONURDF_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=				hpp-manipulation-urdf
endif

ifeq (+,$(HPPMANIPULATIONURDF_DEPEND_MK)) # ---------------------------

PREFER.hpp-manipulation-urdf?=		robotpkg

DEPEND_USE+=				hpp-manipulation-urdf

include ../../meta-pkgs/hpp/depend.common
DEPEND_ABI.hpp-manipulation-urdf?=	hpp-manipulation-urdf>=${HPP_MIN_VERSION}
DEPEND_DIR.hpp-manipulation-urdf?=	../../path/hpp-manipulation-urdf

SYSTEM_SEARCH.hpp-manipulation-urdf=											\
	'include/hpp/manipulation/urdf/config.hh:/HPP_MANIPULATION_VERSION /s/[^0-9.]//gp'				\
	'lib/cmake/hpp-manipulation-urdf/hpp-manipulation-urdfConfigVersion.cmake:/PACKAGE_VERSION/s/[^0-9.]//gp'	\
	'lib/libhpp-manipulation-urdf.so'										\
	'lib/pkgconfig/hpp-manipulation-urdf.pc:/Version/s/[^0-9.]//gp'							\
	'share/hpp-manipulation-urdf/package.xml:/<version>/s/[^0-9.]//gp'

endif # HPPMANIPULATIONURDF_DEPEND_MK ---------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
