#
# spec file for package susemanager-cloud-setup
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

%define base_name susemanager-cloud-setup

Name:           %{base_name}
Version:        5.0
Release:        0
Summary:        Storage setup scripts for SUSE Manager
License:        GPL-3.0-or-later
Group:          System/Management
Url:            https://github.com/SUSE-Enceladus/susemanager-cloud-setup
Source:         %{base_name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch

%description
Scripts that help setting up SUSE Manager storage after deployment.

%package server
Summary: Storage setup scripts for SUSE Manager Server
Conflicts:      %{base_name}-proxy

%description server
Scripts that help setting up SUSE Manager Server storage after deployment.

%package proxy
Summary: Storage setup scripts for SUSE Manager Proxy
Conflicts:      %{base_name}-server

%description proxy
Scripts that help setting up SUSE Manager Proxy storage after deployment.


%prep
%setup -q -n %{base_name}-%{version}

%build

%install
make install DESTDIR=%{buildroot} PREFIX=%{_usr}

%files server
%defattr(-,root,root)
%attr(755,root,root) %{_usr}/bin/mgr-storage-server
%attr(755,root,root) %{_usr}/lib/susemanager
%license LICENSE

%files proxy
%defattr(-,root,root)
%attr(755,root,root) %{_usr}/bin/mgr-storage-proxy
%attr(755,root,root) %{_usr}/lib/susemanager
%license LICENSE


%changelog

