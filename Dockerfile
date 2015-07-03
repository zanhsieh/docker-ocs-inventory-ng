FROM centos:6
MAINTAINER Ming Hsieh <zanhsieh@gmail.com>

RUN yum -y install epel-release ;\
    yum -y update ;\
    yum -y install tar gzip make httpd mysql mysql-server php php-mysql php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml php-mbstring php-pecl-zip python-pip perl-XML-Simple perl-Compress-Zlib perl-DBI perl-DBD-MySQL perl-Apache-DBI perl-Net-IP perl-SOAP-Lite mod_perl;\
    yum clean all

ADD OCSNG_UNIX_SERVER-2.1.2.tar.gz /tmp/
ADD s6-1.1.3.2-musl-static.tar.xz /
RUN cd /tmp/OCSNG_UNIX_SERVER-2.1.2/Apache/ ;\
    perl Makefile.PL ;\
    make ;\
    make install ;\
    cp -R blib/lib/Apache /usr/local/share/perl5/ ;\
    cp ../etc/logrotate.d/ocsinventory-server /etc/logrotate.d/ ;\
    mkdir -p /etc/ocsinventory-server/{plugins,perl} ;\
    mkdir -p /usr/share/ocsinventory-reports ;\
    cd .. ;\
    cp -R ocsreports /usr/share/ocsinventory-reports/ ;\
    chown root:apache -R /usr/share/ocsinventory-reports/ocsreports ;\
    mkdir -p /var/lib/ocsinventory-reports/{download,ipd,logs,scripts,snmp} ;\
    chown root:apache -R /var/lib/ocsinventory-reports/{download,ipd,logs,scripts,snmp} ;\
    cp binutils/ipdiscover-util.pl /usr/share/ocsinventory-reports/ocsreports/ipdiscover-util.pl ;\
    chown root:apache /usr/share/ocsinventory-reports/ocsreports/ipdiscover-util.pl ;\
    chmod 755 /usr/share/ocsinventory-reports/ocsreports/ipdiscover-util.pl

COPY rootfs /
COPY *.conf /etc/httpd/conf.d/
COPY dbconfig.inc.php /usr/share/ocsinventory-reports/ocsreports/
COPY init_db.sh ocsweb.sql /tmp/
RUN chmod +w /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php ;\
    chmod +x /tmp/init_db.sh; \
    /tmp/init_db.sh; \
    rm -fR /tmp/OCSNG_UNIX_SERVER-2.1.2

EXPOSE 80 3306

VOLUME ["/var/lib/mysql", "/var/log"]

ENTRYPOINT ["/usr/local/bin/init"]
