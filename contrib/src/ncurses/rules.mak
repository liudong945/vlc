# ncurses

NCURSES_VERSION := 5.9
NCURSES_URL := $(GNU)/ncurses/ncurses-$(NCURSES_VERSION).tar.gz

PKGS += ncurses

ifeq ($(call need_pkg,"ncursesw"),)
PKGS_FOUND += ncurses
endif

$(TARBALLS)/ncurses-$(NCURSES_VERSION).tar.gz:
	$(call download,$(NCURSES_URL))

.sum-ncurses: ncurses-$(NCURSES_VERSION).tar.gz

ncurses: ncurses-$(NCURSES_VERSION).tar.gz .sum-ncurses
	$(UNPACK)
	$(MOVE)

.ncurses: ncurses
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) --without-debug --enable-widec --without-develop --without-shared --with-terminfo-dirs=/usr/share/terminfo
	cd $</ncurses && make && make install
	cd $</include && make && make install
	touch $@
