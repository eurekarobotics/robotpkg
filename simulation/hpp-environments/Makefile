# robotpkg Makefile for:	simulation/hpp-environments
# Created:			Guilhem Saurel on Mon,  4 May 2020
#

HPP_PACKAGE=		hpp-environments
HPP_COMMENT=		Environments and robot descriptions for HPP

CATEGORIES=		simulation

CMAKE_ARGS+=		-DBUILD_PYTHON_INTERFACE=OFF

include ../../meta-pkgs/hpp/Makefile.common

include ../../robots/example-robot-data/depend.mk
include ../../mk/language/c.mk
include ../../mk/language/c++.mk
include ../../mk/robotpkg.mk
