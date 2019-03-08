.PHONY: install-common install-server install-proxy
DESTDIR?=
PREFIX?=/usr
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/lib/susemanager
DEST_BINDIR=$(DESTDIR)$(BINDIR)
DEST_LIBDIR=$(DESTDIR)$(LIBDIR)

version=$(shell rpm -q --specfile --qf '%{VERSION}\n' susemanager-cloud-setup.spec | head -n1)

install:
	mkdir -p $(DEST_BINDIR)
	mkdir -p $(DEST_LIBDIR)/bin
	mkdir -p $(DEST_LIBDIR)/hooks
	install -m 755 susemanager-cloud-setup-functions.sh $(DEST_LIBDIR)/bin
	install -m 755 suma_completehook.sh $(DEST_LIBDIR)/hooks
	install -m 755 suma-storage-server $(DEST_BINDIR)
	install -m 755 suma-storage-proxy $(DEST_BINDIR)

tarball:
	mkdir susemanager-cloud-setup-$(version)
	cp LICENSE Makefile suma_completehook.sh susemanager-cloud-setup-functions.sh suma-storage-server suma-storage-proxy susemanager-cloud-setup-$(version)
	tar czf susemanager-cloud-setup-$(version).tar.gz susemanager-cloud-setup-$(version)
	rm -r susemanager-cloud-setup-$(version)
