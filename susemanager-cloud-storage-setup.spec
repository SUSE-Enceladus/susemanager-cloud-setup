#
# spec file for package susemanager-cloud-setup-storage
#
# Copyright (c) 2019 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           susemanager-cloud-storage-setup
Version:        1.0
Release:        0
Summary:        Storage setup script for SUSE Manager
License:        GPL-3.0-or-later
Group:          System/Management
Url:            https://github.com/SUSE-Enceladus/susemanager-cloud-setup
Source:         susemanager-cloud-storage-setup-%{version}.tar.gz

%description
A script that sets up external storage for SUSE Manager.

%package server
Summary:        Storage setup script for SUSE Manager Server
Conflicts:      %{name}-proxy

%description server
A script that sets up external storage for SUSE Manager Server.

%package proxy
Summary:        Storage setup script for SUSE Manager Proxy
Conflicts:      %{name}-server

%description proxy
A script that sets up external storage for SUSE Manager Proxy.

%prep
%setup -q -n %{name}-%{version}

%build

%install
make install DESTDIR=%{buildroot} PREFIX=%{_usr}

%post -n susemanager-cloud-storage-setup-server
ln -sf suma-storage-server %{_usr}/bin/suma-storage

%post -n susemanager-cloud-storage-setup-proxy
ln -sf suma-storage-proxy %{_usr}/bin/suma-storage

%files -n susemanager-cloud-storage-setup-server
%attr(755,root,root) %{_usr}/bin/suma-storage-server
%attr(755,root,root) %{_usr}/lib/susemanager
%ghost %{_usr}/bin/suma-storage
%license LICENSE

%files -n susemanager-cloud-setup-proxy
%attr(755,root,root) %{_usr}/bin/suma-storage-proxy
%attr(755,root,root) %{_usr}/lib/susemanager
%ghost %{_usr}/bin/suma-storage
%license LICENSE

%changelog

