# robotpkg Makefile for:	image/coriander
# Created:			Anthony Mallet on Mon, 23 Jun 2008
#

DISTNAME=		coriander-2.0.1
CATEGORIES=		image
MASTER_SITES=\
  https://damien.douxchamps.net/ieee1394/coriander/archives/

MAINTAINER=		openrobots@laas.fr
HOMEPAGE=		http://damien.douxchamps.net/ieee1394/coriander/
COMMENT=		Graphical user interface for controlling FireWire cameras
LICENSE=		gnu-gpl-v2

ONLY_FOR_PLATFORM=	Linux-%
GNU_CONFIGURE=		yes

CFLAGS+=		-fcommon

# issue with po/Makefile
MAKE_FLAGS+=		SUBDIRS=src

include ../../image/libdc1394/depend.mk
include ../../image/libraw1394/depend.mk
include ../../pkgtools/pkg-config/depend.mk
include ../../mk/sysdep/libgnomeui.mk
include ../../mk/sysdep/libXv.mk
include ../../mk/sysdep/SDL.mk
include ../../mk/language/c.mk
include ../../mk/robotpkg.mk
