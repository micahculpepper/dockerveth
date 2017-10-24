NAME := dockerveth
VERSION := $(shell grep '^Version:' SPECS/dockerveth.spec | awk '{print $$2}')

.PHONY: clean all rpm

all: rpm
	:

clean:
	-rm -rf $(NAME)-$(VERSION)
	-rm -rf $(NAME)-$(VERSION).tar.gz

rpm:
	-rm -rf $(NAME)-$(VERSION)
	mkdir $(NAME)-$(VERSION)
	mkdir -p -m0755 $(NAME)-$(VERSION)/usr/bin
	install -m 755 $(NAME).sh $(NAME)-$(VERSION)/usr/bin/$(NAME)
	tar -zcvf $(NAME)-$(VERSION).tar.gz $(NAME)-$(VERSION)
	cp $(NAME)-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
	rpmbuild -bs SPECS/$(NAME).spec
