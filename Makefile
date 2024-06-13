.PHONY: install-common install-server install-proxy
DESTDIR?=
PREFIX?=/usr
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib/susemanager
DEST_BINDIR=$(DESTDIR)$(BINDIR)
DEST_LIBDIR=$(DESTDIR)$(LIBDIR)

version=$(shell rpm -q --specfile --qf '%{VERSION}\n' susemanager-cloud-setup.spec 2>/dev/null 2>/dev/null | head -n1)

install: install-server install-proxy

install-common:
	mkdir -p $(DEST_BINDIR)
	mkdir -p $(DEST_LIBDIR)
	install -m 755 susemanager-storage-setup-functions.sh $(DEST_LIBDIR)

install-server: install-common
	install -m 755 mgr-storage-server $(DEST_BINDIR)/mgr-storage-server

install-proxy: install-common
	install -m 755 mgr-storage-proxy $(DEST_BINDIR)/mgr-storage-proxy

tarball:
	mkdir susemanager-cloud-setup-$(version)
	cp LICENSE Makefile susemanager-storage-setup-functions.sh mgr-storage-server mgr-storage-proxy susemanager-cloud-setup-$(version)
	tar czf susemanager-cloud-setup-$(version).tar.gz susemanager-cloud-setup-$(version)
	rm -r susemanager-cloud-setup-$(version)
