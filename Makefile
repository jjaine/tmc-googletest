
PREFIX=/usr/local

CONVERTER=tmc-googletest-convert-results

all: rubygems

rubygems: .rubygems_installed

.rubygems_installed:
	bundle install
	touch .rubygems_installed

clean:
	rm -f .rubygems_installed

install: 
	install -m 755 $(CONVERTER) $(PREFIX)/bin
	
uninstall:
	rm -f $(PREFIX)/bin/$(CONVERTER)
