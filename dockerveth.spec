Summary: Show which docker containers are attached to which veth interfaces.
Name: dockerveth
Version: 1.0
Release: 1
License: GPLv3+
Group: Development/Tools
Source : %{name}-%{version}.tar.gz
URL: https://github.com/micahculpepper/dockerveth
BuildArch: noarch
Packager: Micah Culpepper <micahculpepper@gmail.com>

%description
%{summary}

%prep
%setup

%build
# Empty section.

%install
pwd
ls
install -m 0755 usr/bin/dockerveth %{_bindir}/dockerveth

%check
# Empty section.

%files
%doc README.md
%{_bindir}/dockerveth

%changelog
* Mon Oct 23 2017 Micah Culpepper <micahculpepper@gmail.com>
- Version 1.0
