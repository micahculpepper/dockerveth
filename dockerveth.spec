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

BuildRoot: %{_tmppath}/%{name}-buildroot

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
mkdir -p -m0755 $RPM_BUILD_ROOT%{_bindir}
install -m 0755 dockerveth $RPM_BUILD_ROOT%{_bindir}/

%check
# Empty section.

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%{_bindir}/%{name}

%changelog
* Mon Oct 23 2017 Micah Culpepper <micahculpepper@gmail.com>
- Version 1.0
