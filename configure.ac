dnl Process this file with autoconf to produce a configure script.
dnl Created by Anjuta application wizard.

AC_INIT([Ease],
	[0.9],
	[stephane.maniaci@gmail.com],
	[ease],
	[http://freesteph.info])
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

AC_SUBST([PACKAGE_NAME], ["$PACKAGE_NAME"])
AC_SUBST([PACKAGE_VERSION], ["$PACKAGE_VERSION"])

AM_INIT_AUTOMAKE([foreign])
AC_CONFIG_HEADERS([config.h])
AM_MAINTAINER_MODE

AC_PROG_CC



dnl Check for vala
AM_PROG_VALAC([0.10.0])


PKG_CHECK_MODULES(EASE, [gtk+-3.0 json-glib-1.0 gee-1.0 clutter-gtk-1.0 clutter-1.0])


AC_OUTPUT([
Makefile
src/Makefile

])
