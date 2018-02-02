# robotpkg depend.mk for:	middleware/ace
# Created:			Anthony Mallet on Mon, 2 Jun 2008
#

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
ACE_DEPEND_MK:=		${ACE_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		ace
endif

ifeq (+,$(ACE_DEPEND_MK)) # ------------------------------------------

include ../../mk/robotpkg.prefs.mk # for OPSYS
ifeq (Debian,${OPSYS})
  PREFER.ace?=		system
else ifeq (Ubuntu,${OPSYS})
  PREFER.ace?=		system
endif
PREFER.ace?=		robotpkg

DEPEND_USE+=		ace

DEPEND_ABI.ace?=	ace>=5.6
DEPEND_DIR.ace?=	../../middleware/ace

SYSTEM_SEARCH.ace=\
	include/ace/ACE.h					\
	'include/ace/Version.h:/ACE_VERSION/s/[^0-9.]//gp'	\
	'lib/libACE.{a,so}'					\
	'lib/pkgconfig/ACE.pc:/Version/s/[^0-9.]//gp'

SYSTEM_PKG.Debian.ace=	libace-dev
SYSTEM_PKG.Fedora.gtar=	tar

endif # ACE_DEPEND_MK ------------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
