FROM centos:7

RUN yum -y install epel-release && \
    yum -y update && \
    yum -y install gcc make gpg rpm-build redhat-rpm-config rpm-sign

ARG commit

LABEL name="dockerveth RPM builder" \
      author="Micah Culpepper <micahculpepper@gmail.com>" \
      license="GPLv3+" \
      repo="https://github.com/micahculpepper/dockerveth" \
      commit="${commit}"

RUN mkdir /home/root
ENV HOME /home/root
WORKDIR /home/root

COPY [".", "/home/root/"]

CMD ["make", "rpm"]
