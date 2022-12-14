#
# Copyright (c) 2006-2011,2013,2018,2022 LAAS/CNRS
# All rights reserved.
#
# This project includes software developed by the NetBSD Foundation, Inc.
# and its contributors. It is derived from the 'pkgsrc' project
# (http://www.pkgsrc.org).
#
# Redistribution  and  use in source   and binary forms,  with or without
# modification, are permitted provided that  the following conditions are
# met:
#
#   1. Redistributions  of  source code must  retain  the above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must  reproduce the above copyright
#      notice,  this list of  conditions and  the following disclaimer in
#      the  documentation   and/or  other  materials   provided with  the
#      distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE  AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY  EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES   OF MERCHANTABILITY AND  FITNESS  FOR  A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO  EVENT SHALL THE AUTHOR OR  CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT,  INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING,  BUT  NOT LIMITED TO, PROCUREMENT  OF
# SUBSTITUTE  GOODS OR SERVICES;  LOSS   OF  USE,  DATA, OR PROFITS;   OR
# BUSINESS  INTERRUPTION) HOWEVER CAUSED AND  ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE  USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# From $NetBSD: build.mk,v 1.9 2006/11/09 02:53:15 rillig Exp $
#
#                                       Anthony Mallet on Set Dec  2 2006
#

# This file defines what happens in the build phase, excluding the
# self-test, which is defined in test.mk.
#
# Package-settable variables:
#
# BUILD_MAKE_FLAGS is the list of arguments that is passed to the make
#	process, in addition to the usual MAKE_FLAGS.
#
# BUILD_TARGET is the target from ${MAKE_FILE} that should be invoked
#	to build the sources.
#
# MAKE_JOBS_SAFE
#	Whether the package supports parallel builds. If set to yes,
#	at most MAKE_JOBS jobs are carried out in parallel. The default
#	value is "yes", and packages that don't support it must
#	explicitly set it to "no".
#
# Variables defined in this file:
#
# BUILD_MAKE_CMD
#	This command sets the proper environment for the build phase
#	and runs make(1) on it. It takes a list of make targets and
#	flags as argument.
#

$(call require, ${ROBOTPKG_DIR}/mk/build/build-vars.mk)


# --- build (PUBLIC) -------------------------------------------------
#
# build is a public target to build the sources from the package.
#
$(call require, ${ROBOTPKG_DIR}/mk/depends/depends-vars.mk)
$(call require, ${ROBOTPKG_DIR}/mk/configure/configure.mk)

_BUILD_TARGETS+=	$(call add-barrier, depends, build)
_BUILD_TARGETS+=	configure
_BUILD_TARGETS+=	acquire-build-lock
_BUILD_TARGETS+=	${_COOKIE.build}
_BUILD_TARGETS+=	release-build-lock

.PHONY: build
build: ${_BUILD_TARGETS};
all: $(call add-barrier, depends, all);

.PHONY: acquire-build-lock release-build-lock
acquire-build-lock: acquire-lock
release-build-lock: release-lock


# --- build-cookie (PRIVATE) -----------------------------------------------
#
# ${_COOKIE.build} creates the "build" cookie file.
#
ifeq (yes,$(call exists,${_COOKIE.build}))
  ifneq (,$(filter build all,${MAKECMDGOALS}))
    ${_COOKIE.build}: .FORCE
  else ifdef _EXTRACT_IS_CHECKOUT
    ${_COOKIE.build}: .FORCE
  endif

  _MAKEFILE_WITH_RECIPES+=${_COOKIE.build}
  ${_COOKIE.build}: ${_COOKIE.configure}
	${RUN}${TEST} ! -f $@ || ${MV} -f $@ $@.prev

  _cbbh_requires+=	${_COOKIE.build}
else
  ${_COOKIE.build}: real-build;
endif

.PHONY: build-cookie
build-cookie: makedirs
	${RUN}${TEST} ! -f ${_COOKIE.build} || ${FALSE};	\
	exec >>${_COOKIE.build};				\
	${ECHO} "_COOKIE.build.date:=`${_CDATE_CMD}`"


# --- real-build (PRIVATE) -------------------------------------------
#
# real-build is a helper target onto which one can hook all of the
# targets that do the actual building of the sources.
#
ifdef NO_BUILD
  _REAL_BUILD_TARGETS+=	build-cookie
else
  _REAL_BUILD_TARGETS+=	build-check-interactive
  _REAL_BUILD_TARGETS+=	build-message
  _REAL_BUILD_TARGETS+=	build-check-dirs
  _REAL_BUILD_TARGETS+=	pre-build
  _REAL_BUILD_TARGETS+=	do-build
  _REAL_BUILD_TARGETS+=	post-build
  _REAL_BUILD_TARGETS+=	build-cookie
  ifneq (,$(filter build all,${MAKECMDGOALS}))
    _REAL_BUILD_TARGETS+=	build-done-message
  endif
endif

.PHONY: real-build
real-build: ${_REAL_BUILD_TARGETS};

.PHONY: build-message
build-message:
	@if ${TEST} -f "${_COOKIE.build}.prev"; then			\
	  ${PHASE_MSG} "Rebuilding for ${PKGNAME}";			\
	else								\
	  ${PHASE_MSG} "Building for ${PKGNAME}";			\
	fi
	${RUN}								\
	${ECHO} "--- Environment ---" >${BUILD_LOGFILE};		\
	${SETENV} >>${BUILD_LOGFILE};					\
	${ECHO} "---" >>${BUILD_LOGFILE}


# --- build-check-interactive (PRIVATE) ------------------------------
#
# build-check-interactive checks whether we must do an interactive
# build or not.
#
build-check-interactive:
ifdef BATCH
 ifneq (,$(filter build,${INTERACTIVE_STAGE}))
	@${ERROR_MSG} "The build stage of this package requires user interaction"
	@${ERROR_MSG} "Please build manually with:"
	@${ERROR_MSG} "    \"cd ${.CURDIR} && ${MAKE} build\""
	@${TOUCH} ${_INTERACTIVE_COOKIE}
	@${FALSE}
 else
	@${DO_NADA}
 endif
else
	@${DO_NADA}
endif


# --- build-check-dirs (PRIVATE) -------------------------------------
#
# build-check-dirs checks whether the build directories exist.
#
build-check-dirs:
	${_PKG_SILENT}${_PKG_DEBUG}					\
${foreach _dir_,$(BUILD_DIRS),						\
	if (cd $(WRKSRC) && cd $(_dir_)) 1>/dev/null 2>&1; then :; else	\
	$(ERROR_MSG) "The build directory of $(PKGNAME) cannot be found.";\
	$(ERROR_MSG) "Perhaps a stale work directory?";			\
	$(ERROR_MSG) "Try to";						\
	$(ERROR_MSG) "	${MAKE} clean in $(PKGPATH)"; 			\
	exit 2;								\
	fi;								\
}


# --- pre-build, do-build, post-build (PUBLIC, override) -------------
#
# {pre,do,post}-build are the heart of the package-customizable
# build targets, and may be overridden within a package Makefile.
#

pre-build do-build post-build: SHELL=${BUILD_LOGFILTER}
pre-build do-build post-build: .SHELLFLAGS=--

DO_BUILD_TARGET?= do-build-make(${BUILD_DIRS})

do%build: ${DO_BUILD_TARGET}
	${_OVERRIDE_TARGET}

.PHONY: do-build-make()
do-build-make(%): .FORCE
	${RUN} cd ${WRKSRC} && cd '$%' && $(call BUILD_MAKE_CMD,$%)

.PHONY: pre-build post-build
pre-build:

post-build:
