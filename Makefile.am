## Process this file with automake to produce Makefile.in
## Created by Anjuta

SUBDIRS = src 

easedocdir = ${prefix}/doc/ease
easedoc_DATA = \
	README \
	COPYING \
	AUTHORS \
	NEWS


EXTRA_DIST = $(easedoc_DATA)


# Remove doc directory on uninstall
uninstall-local:
	-rm -r $(easedocdir)
