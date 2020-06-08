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

%if "@BUILD_FLAVOR@" == ""
%define flavor_suffix %nil
ExclusiveArch:  do-not-build
%endif
%if "@BUILD_FLAVOR@" == "server"
%define flavor_suffix -server
%endif
%if "@BUILD_FLAVOR@" == "proxy"
%define flavor_suffix -proxy
%endif

Name:           %{base_name}%{flavor_suffix}
Version:        1.5
Release:        0
Summary:        Cloud specific setup scripts for SUSE Manager
License:        GPL-3.0-or-later
Group:          System/Management
Url:            https://github.com/SUSE-Enceladus/susemanager-cloud-setup
Source:         %{base_name}-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch
Provides:       %{base_name}
Conflicts:      %{base_name}

%description -n %{base_name}%{flavor_suffix}
Scripts that help setting up SUSE Manager in the cloud.

%prep
%setup -q -n %{base_name}-%{version}

%build

%install
make install%{flavor_suffix} DESTDIR=%{buildroot} PREFIX=%{_usr}

%files -n %{base_name}%{flavor_suffix}
%defattr(-,root,root)
%attr(755,root,root) %{_usr}/bin/suma-storage
%attr(755,root,root) %{_usr}/lib/susemanager
%license LICENSE

%changelog

