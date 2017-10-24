name := dockerveth
version := $(shell grep '^Version:' SPECS/dockerveth.spec | awk '{print $$2}')
author := $(shell printf "$$(git config --get user.name) <$$(git config --get user.email)>")

.phony: clean all rpm

all: rpm
	:

clean:
	-rm -rf $(NAME)-$(VERSION)
	-rm -rf $(NAME)-$(VERSION).tar.gz

rpm:
	git diff-index --quiet HEAD --  # Verify there are no uncommited changes, as the commit will be recorded in the built image.
	docker build -t dockervethrpm:$(version) --build-arg commit=$(commit) --build-arg author=$(author) .
	docker run dockervethrpm:$(version)

rpmbuild:
	ls -al
#	-rm -rf $(NAME)-$(VERSION)
#	mkdir $(NAME)-$(VERSION)
#	mkdir -p -m0755 $(NAME)-$(VERSION)/usr/bin
#	install -m 755 $(NAME).sh $(NAME)-$(VERSION)/usr/bin/$(NAME)
#	tar -zcvf $(NAME)-$(VERSION).tar.gz $(NAME)-$(VERSION)
#	cp $(NAME)-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
#	rpmbuild -bs SPECS/$(NAME).spec
