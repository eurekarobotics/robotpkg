# $NetBSD: deinstall.mk,v 1.7 2006/11/03 08:04:06 joerg Exp $

# DEINSTALLDEPENDS controls whether dependencies and dependents are also
# removed when a package is de-installed.  The valid values are:
#
#    no		only the package is removed (if dependencies allow it)
#    yes	dependent packages are also removed
#    all	dependent packages and unused dependencies are also removed
#
DEINSTALLDEPENDS?=	no

# --- deinstall, su-deinstall (PUBLIC) -------------------------------
#
# deinstall is a public target to remove an installed package.
#
_DEINSTALL_TARGETS=	deinstall-message
_DEINSTALL_TARGETS=	acquire-deinstall-lock
_DEINSTALL_TARGETS+=	pkg-deinstall
_DEINSTALL_TARGETS+=	release-deinstall-lock
_DEINSTALL_TARGETS+=	install-clean

.PHONY: deinstall
deinstall: ${_DEINSTALL_TARGETS}

.PHONY: deinstall-message
deinstall-message:
	@${PHASE_MSG} "Deinstalling for ${PKGNAME}"

.PHONY: acquire-deinstall-lock release-deinstall-lock
acquire-deinstall-lock: acquire-localbase-lock
release-deinstall-lock: release-localbase-lock


# --- reinstall (PUBLIC) ---------------------------------------------
#
# reinstall is a special target to re-run the install target.
#
.PHONY: reinstall
reinstall: install-clean install
