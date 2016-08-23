#!/bin/bash
set -e

usage()
{
    echo "Usage:"
    echo "      $0 55|56|57"
}

if [ -z "$1" ]
then
	usage
	exit 1
fi

case $1 in
    "55" )
	deb_version="5.5"
	rpm_version="55"
	lib_version="18"
        ;;
    "56" )
	deb_version="5.6"
	rpm_version="56"
	lib_version="18.1"
        ;;
    "57" )
	deb_version="5.7"
	rpm_version="57"
	lib_version="20"
        ;;
esac


if [ -f /etc/redhat-release ]; then
	rpm -qa | grep Percona
	yum remove -y Percona-Server-client-${rpm_version} Percona-Server-server-${rpm_version} Percona-Server-${rpm_version}-debuginfo Percona-Server-devel-${rpm_version} Percona-Server-shared-${rpm_version} Percona-Server-test-${rpm_version}
	rpm -qa | grep Percona
else
	dpkg -l | grep percona

	apt-get remove -y libperconaserverclient${lib_version} percona-server-${deb_version}-dbg percona-server-client-${deb_version} percona-server-common-${deb_version} percona-server-source-${deb_version} percona-server-test-${deb_version} percona-xtrabackup

	dpkg -l | grep percona
fi



