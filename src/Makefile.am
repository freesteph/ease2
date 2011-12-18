## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(datadir)/ease/ui
ui_DATA = ease-main-window.ui


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	$(EASE_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

VALAFLAGS =  \
	--pkg gtk+-3.0 \
	--pkg clutter-1.0 \
	--pkg clutter-gtk-1.0 \
	--pkg gee-1.0 \
	--pkg gmodule-2.0 \
	--vapidir . \
	--pkg config

bin_PROGRAMS = ease

ease_SOURCES = \
	ease-main.vala \
	ease-main-window.vala \
	ease-document.vala \
	ease-slide.vala \
	ease-element.vala

ease_LDFLAGS = \
	-Wl,--export-dynamic

ease_LDADD = $(EASE_LIBS)


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(datadir)/ease
