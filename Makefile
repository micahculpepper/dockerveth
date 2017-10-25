name := dockerveth
version := $(shell grep '^Version:' SPECS/dockerveth.spec | awk '{print $$2}')
commit = $(shell git rev-parse HEAD)
gpg_id = $(shell git config --get user.signingkey)
here = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

.phony: clean all rpm rpmbuildercontainer

all:
	:

clean:
	-rm -rf $(name)-$(version)
	-rm -rf $(name)-$(version).tar.gz
	-rm -rf $(here)/rpmbuild

rpm_container_build:
	git diff-index --quiet HEAD --  # Verify there are no uncommited changes, as the commit will be recorded in the built image.
	docker build -t dockervethrpm:$(version) --build-arg commit=$(commit) .
	-mkdir -p rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}
	docker run --rm -e gpg_id=$(gpg_id) -v ~/.gnupg:/home/root/.gnupg:ro -v $(here)/rpmbuild:/home/root/rpmbuild dockervethrpm:$(version)


rpm:
	mkdir $(name)-$(version)
	mkdir -p -m0755 $(name)-$(version)/usr/bin
	install -m 755 $(name).sh $(name)-$(version)/usr/bin/$(name)
	tar -zcvf $(name)-$(version).tar.gz $(name)-$(version)
	cp $(name)-$(version).tar.gz $(HOME)/rpmbuild/SOURCES/
	rpmbuild -bs SPECS/$(name).spec
