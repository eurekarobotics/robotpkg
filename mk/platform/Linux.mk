# $NetBSD: NetBSD.mk,v 1.21 2006/07/20 20:02:23 jlam Exp $
#
# Variable definitions for the Linux operating system.

ECHO_N?=	${ECHO} -n
PKGLOCALEDIR?=	share

CPP_PRECOMP_FLAGS?=	# unset
EXPORT_SYMBOLS_LDFLAGS?=-Wl,-E	# add symbols to the dynamic symbol table

_OPSYS_SHLIB_TYPE=	ELF	# shared lib type
_PATCH_CAN_BACKUP=	yes	# native patch(1) can make backups
_PATCH_BACKUP_ARG?=	-V simple -b -z 	# switch to patch(1) for backup suffix
_USE_RPATH=		yes	# add rpath to LDFLAGS

# Standard commands
TRUE?=			:
FALSE?=			false
SETENV?=		env
TEST?=			test
EXPR?=			expr
CMP?=			cmp
LS?=			ls
WC?=			wc
ECHO?=			echo
CAT?=			cat
GZCAT?=			gzcat
BZCAT?=			bzcat
SED?=			sed
CP?=			cp
LN?=			ln
MV?=			mv
RM?=			rm
MKDIR?=			mkdir -p
DATE?=			date
SORT?=			sort
AWK?=			awk
XARGS?=			xargs -r
SH?=			sh
ID?=			id
GREP?=			grep
TOUCH?=			touch
CHMOD?=			chmod
FIND?=			find
TAR?=			${LOCALBASE}/bin/tar
PAX?=			${LOCALBASE}/bin/pax
BASENAME?=		basename
PATCH?=			patch
LIBTOOL?=		libtool

TOOLS_INSTALL=		/usr/bin/install
TOOLS_DIGEST=		digest
TOOLS_ECHO=		echo
TOOLS_CAT=		cat
TOOLS_TEST=		test
DEF_UMASK?=		0022
