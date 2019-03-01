.PHONY: install-common install-server install-proxy
DESTDIR?=
PREFIX?=/usr
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib/susemanager/bin
DEST_BINDIR=$(DESTDIR)$(BINDIR)
DEST_LIBDIR=$(DESTDIR)$(LIBDIR)

version=$(shell rpm -q --specfile --qf '%{VERSION}\n' susemanager-cloud-setup.spec | head -n1)

install:
	mkdir -p $(DEST_BINDIR)
	mkdir -p $(DEST_LIBDIR)
	install -m 755 susemanager-cloud-storage-setup-functions.sh $(DEST_LIBDIR)
	install -m 755 suma-storage-server $(DEST_BINDIR)
	install -m 755 suma-storage-proxy $(DEST_BINDIR)

tarball:
	mkdir susemanager-cloud-storage-setup-$(version)
	cp LICENSE Makefile susemanager-cloud-storage-setup-functions.sh suma-storage-server suma-storage-proxy susemanager-cloud-setup-$(version)
	tar czf susemanager-cloud-storage-setup-$(version).tar.gz susemanager-cloud-storage-setup-$(version)
	rm -r susemanager-cloud-storage-setup-$(version)
