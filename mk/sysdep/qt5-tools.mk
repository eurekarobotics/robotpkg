# robotpkg sysdep/qt5-tools
# Created: Anthony Mallet on 04 Jun 2019
#
DEPEND_DEPTH:=		${DEPEND_DEPTH}+
QT5_TOOLS_DEPEND_MK:=	${QT5_TOOLS_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		qt5-tools
endif

ifeq (+,$(QT5_TOOLS_DEPEND_MK)) # ------------------------------------------

PREFER.qt5-tools?=	system

DEPEND_USE+=		qt5-tools
DEPEND_ABI.qt5-tools?=	qt5-tools>=5.0.0

SYSTEM_SEARCH.qt5-tools=\
  'include/{,qt{,5}/{,include/}}Qt{,Designer}/QtDesigner'	\
  '{lib,share/qt5/lib,lib/qt5}/libQt5Designer.{so,a}'		\
  '{,lib}/cmake/Qt5Designer/Qt5DesignerConfig.cmake'		\
  '{,lib}/cmake/Qt5LinguistTools/Qt5LinguistToolsConfig.cmake'	\
  '{,lib}/cmake/Qt5UiTools/Qt5UiToolsConfig.cmake'		\
  'lib/pkgconfig/Qt5Designer.pc:/Version/s/[^0-9.]//gp'

SYSTEM_PREFIX.qt5-tools?=	${SYSTEM_PREFIX:=/qt5} ${SYSTEM_PREFIX}

SYSTEM_PKG.Debian.qt5-tools=	qttools5-dev-tools qttools5-dev
SYSTEM_PKG.NetBSD.qt5-tools=	x11/qt5-qttools
SYSTEM_PKG.RedHat.qt5-tools=	qt5-qttools-devel qt5-qttools-static

endif # QT5_TOOLS_DEPEND_MK ------------------------------------------

DEPEND_DEPTH:= ${DEPEND_DEPTH:+=}
