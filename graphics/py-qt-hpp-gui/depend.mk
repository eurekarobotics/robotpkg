# robotpkg depend.mk for:	graphics/py-qt-hpp-gui
# Created:			Guilhem Saurel on Tue, 26 Feb 2019
#

DEPEND_DEPTH:=			${DEPEND_DEPTH}+
PY_QT_HPP_GUI_DEPEND_MK:=	${PY_QT_HPP_GUI_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=			py-qt-hpp-gui
endif

ifeq (+,$(PY_QT_HPP_GUI_DEPEND_MK)) # -----------------------------------------

include ../../mk/sysdep/python.mk

PREFER.py-qt-hpp-gui?=		robotpkg

DEPEND_USE+=			py-qt-hpp-gui

# depend on appropriate Qt version when using Qt, all versions otherwise.
_hppg_qts={qt4,qt5}
_hppg_qt=$(if $(filter qt,${PKG_ALTERNATIVES}),${PKG_ALTERNATIVE.qt},${_hppg_qts})

include ../../meta-pkgs/hpp/depend.common
DEPEND_ABI.py-qt-hpp-gui?=	${PKGTAG.python-}${_hppg_qt}-hpp-gui>=${HPP_MIN_VERSION}
DEPEND_DIR.py-qt-hpp-gui?=	../../graphics/py-qt-hpp-gui

SYSTEM_SEARCH.py-qt-hpp-gui=							\
 'include/hpp/gui/config.hh:/HPP_PLOT_VERSION /s/[^0-9.]//gp'			\
 'lib/cmake/hpp-gui/hpp-guiConfigVersion.cmake:/PACKAGE_VERSION/s/[^0-9.]//gp'	\
 'lib/pkgconfig/hpp-gui.pc:/Version/s/[^0-9.]//gp'				\
 'share/hpp-gui/package.xml:/<version>/s/[^0-9.]//gp'

endif # PY_QT_HPP_GUI_DEPEND_MK -----------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
