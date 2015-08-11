
PREFIX=/usr/local

CHECK_CFLAGS=$(shell pkg-config --cflags check)
CHECK_LDFLAGS=$(shell pkg-config --libs check)
PKG_CONFIG_FILE=tmcgoogletest.pc
CONVERTER=tmc-googletest-convert-results

all: rubygems 

rubygems: .rubygems_installed

.rubygems_installed:
	bundle install
	touch .rubygems_installed

clean:
	rm -f $(PKG_CONFIG_FILE)
	rm -f .rubygems_installed

$(PKG_CONFIG_FILE): $(PKG_CONFIG_FILE).in
	sed 's|__PREFIX__|$(PREFIX)|' < $< > $@

install: $(PKG_CONFIG_FILE)
	install -m 755 -d $(PREFIX)/bin
	install -m 755 -d $(PREFIX)/include
	install -m 755 -d $(PREFIX)/lib
	install -m 755 -d $(PREFIX)/lib/pkgconfig
	install -m 755 $(CONVERTER) $(PREFIX)/bin
	install -m 644 $(PKG_CONFIG_FILE) $(PREFIX)/lib/pkgconfig

uninstall:
	rm -f $(PREFIX)/bin/$(CONVERTER)
	rm -f $(PREFIX)/lib/pkgconfig/$(PKG_CONFIG_FILE)
