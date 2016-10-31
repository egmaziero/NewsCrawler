# $Id: Makefile.in,v 1.37 2013/08/03 22:58:52 tom Exp $
##############################################################################
# Copyright (c) 1998-2012,2013 Free Software Foundation, Inc.                #
#                                                                            #
# Permission is hereby granted, free of charge, to any person obtaining a    #
# copy of this software and associated documentation files (the "Software"), #
# to deal in the Software without restriction, including without limitation  #
# the rights to use, copy, modify, merge, publish, distribute, distribute    #
# with modifications, sublicense, and/or sell copies of the Software, and to #
# permit persons to whom the Software is furnished to do so, subject to the  #
# following conditions:                                                      #
#                                                                            #
# The above copyright notice and this permission notice shall be included in #
# all copies or substantial portions of the Software.                        #
#                                                                            #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    #
# THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        #
# DEALINGS IN THE SOFTWARE.                                                  #
#                                                                            #
# Except as contained in this notice, the name(s) of the above copyright     #
# holders shall not be used in advertising or otherwise to promote the sale, #
# use or other dealings in this Software without prior written               #
# authorization.                                                             #
##############################################################################
#
# Author: Thomas E. Dickey <dickey@clark.net> 1996,1997
#
# Master Makefile for ncurses library.

SHELL = /bin/sh


DESTDIR=
RPATH_LIST=${libdir}
TOP_MFLAGS =  DESTDIR="$(DESTDIR)" RPATH_LIST="$(RPATH_LIST)"



NCURSES_MAJOR	= 5
NCURSES_MINOR	= 9
NCURSES_PATCH	= 20131005

top_srcdir	= .
srcdir		= .

prefix		= /usr
exec_prefix	= ${prefix}
datarootdir	= ${prefix}/share

bindir		= ${exec_prefix}/bin
ticdir		= /usr/share/terminfo
includedir	= ${prefix}/include
includesubdir	= 
libdir		= ${exec_prefix}/lib
mandir		= ${datarootdir}/man

INCLUDEDIR	= ${DESTDIR}${includedir}${includesubdir}

INSTALL		= /usr/bin/install -c
INSTALL_DATA	= ${INSTALL} -m 644

DIRS_TO_MAKE	= lib objects obj_g

all ::	$(DIRS_TO_MAKE)

$(DIRS_TO_MAKE) :
	mkdir $@

preinstall :
	@ echo ''
	@ echo '** Configuration summary for NCURSES $(NCURSES_MAJOR).$(NCURSES_MINOR) $(NCURSES_PATCH):'
	@ echo ''
	@ echo '     extended funcs: '`test 1 != 0 && echo yes || echo no`
	@ echo '     xterm terminfo: 'xterm-new
	@ echo ''
	@ echo '      bin directory: '$(bindir)
	@ echo '      lib directory: '$(libdir)
	@ echo '  include directory: '$(INCLUDEDIR)
	@ echo '      man directory: '$(mandir)
	@ echo ' terminfo directory: '$(ticdir)
	@ echo ''
	@ test "$(INCLUDEDIR)" = "$(prefix)/include" || \
		echo '** Include-directory is not in a standard location'
	@ test ! -f $(INCLUDEDIR)/termcap.h || \
		fgrep NCURSES_VERSION $(INCLUDEDIR)/termcap.h >/dev/null || \
		echo '** Will overwrite non-ncurses termcap.h'
	@ test ! -f $(INCLUDEDIR)/curses.h || \
		fgrep NCURSES_VERSION $(INCLUDEDIR)/curses.h >/dev/null || \
		echo '** Will overwrite non-ncurses curses.h'

distclean \
realclean ::


# Put the common rules here so that we can easily construct the list of
# directories to visit.
all \
clean \
distclean \
mostlyclean \
realclean \
depend \
sources \
tags \
uninstall \
install ::
	cd man && ${MAKE} ${TOP_MFLAGS} $@
	cd include && ${MAKE} ${TOP_MFLAGS} $@
	cd ncurses && ${MAKE} ${TOP_MFLAGS} $@
	cd progs && ${MAKE} ${TOP_MFLAGS} $@
	cd panel && ${MAKE} ${TOP_MFLAGS} $@
	cd menu && ${MAKE} ${TOP_MFLAGS} $@
	cd form && ${MAKE} ${TOP_MFLAGS} $@
	cd test && ${MAKE} ${TOP_MFLAGS} $@
	cd misc && ${MAKE} ${TOP_MFLAGS} $@
	cd c++ && ${MAKE} ${TOP_MFLAGS} $@

libs \
install.libs \
uninstall.libs \
install.includes \
uninstall.includes ::
	cd include && ${MAKE} ${TOP_MFLAGS} $@

lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.ncurses \
uninstall.ncurses ::
	cd ncurses && ${MAKE} ${TOP_MFLAGS} $@

lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.progs \
uninstall.progs ::
	cd progs && ${MAKE} ${TOP_MFLAGS} $@

install.includes \
uninstall.includes \
lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.panel \
uninstall.panel ::
	cd panel && ${MAKE} ${TOP_MFLAGS} $@

install.includes \
uninstall.includes \
lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.menu \
uninstall.menu ::
	cd menu && ${MAKE} ${TOP_MFLAGS} $@

install.includes \
uninstall.includes \
lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.form \
uninstall.form ::
	cd form && ${MAKE} ${TOP_MFLAGS} $@

lint \
libs \
lintlib \
install.libs \
uninstall.libs \
install.test \
uninstall.test ::
	cd test && ${MAKE} ${TOP_MFLAGS} $@

install.includes \
uninstall.includes \
libs \
lintlib \
install.libs \
uninstall.libs \
install.c++ \
uninstall.c++ ::
	cd c++ && ${MAKE} ${TOP_MFLAGS} $@

install.libs uninstall.libs \
install.data uninstall.data ::
	cd misc && ${MAKE} ${TOP_MFLAGS} $@

install.man \
uninstall.man ::
	cd man && ${MAKE} ${TOP_MFLAGS} $@

distclean ::
	rm -f config.cache config.log config.status Makefile include/ncurses_cfg.h
	rm -f headers.sh headers.sed mk_shared_lib.sh
	rm -f edit_man.* man_alias.*
	rm -rf ${DIRS_TO_MAKE}
