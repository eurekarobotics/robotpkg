# robotpkg depend.mk for:	simulation/py-hpp-environments
# Created:			Guilhem Saurel on Tue, 14 Apr 2020
#

DEPEND_DEPTH:=			${DEPEND_DEPTH}+
PY_HPP_ENVIRONMENTS_DEPEND_MK:=	${PY_HPP_ENVIRONMENTS_DEPEND_MK}+

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=			py-hpp-environments
endif

ifeq (+,$(PY_HPP_ENVIRONMENTS_DEPEND_MK)) # --------------------------------

include ../../mk/sysdep/python.mk

PREFER.py-hpp-environments?=	robotpkg

DEPEND_USE+=			py-hpp-environments

include ../../meta-pkgs/hpp/depend.common
DEPEND_ABI.py-hpp-environments?=${PKGTAG.python-}hpp-environments>=${HPP_MIN_VERSION}
DEPEND_DIR.py-hpp-environments?=../../simulation/py-hpp-environments

SYSTEM_SEARCH.py-hpp-environments=\
  '${PYTHON_SYSLIBSEARCH}/hpp/environments/robot.py'

endif # PY_HPP_ENVIRONMENTS_DEPEND_MK --------------------------------------

DEPEND_DEPTH:=			${DEPEND_DEPTH:+=}
