FROM centos:7
LABEL maintainer="khanh@bitsensor.io"

RUN yum install -y \
  openssl \
  httpd \
  mod_auth_mellon \
  mod_ssl \
  gettext \
  wget \
  && yum clean all

# Add mod_auth_mellon setup script
ADD https://raw.githubusercontent.com/Uninett/mod_auth_mellon/master/mellon_create_metadata.sh /usr/sbin/mellon_create_metadata.sh
RUN chmod +x /usr/sbin/mellon_create_metadata.sh

# Add conf file for Apache
ADD proxy.conf /etc/httpd/conf.d/proxy.conf.template

EXPOSE 80

ADD configure /usr/sbin/configure
ENTRYPOINT /usr/sbin/configure
