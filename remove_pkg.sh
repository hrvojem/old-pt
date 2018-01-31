#!/bin/bash
set -e

usage()
{
    echo "Usage:"
    echo "      $0 ps55|ps56|ps57"
}

if [ -z "$1" ]
then
	usage
	exit 1
fi

case $1 in
    "ps55" )
	deb_version="5.5"
	rpm_version="55"
	lib_version="18"
        ;;
    "ps56" )
	deb_version="5.6"
	rpm_version="56"
	lib_version="18.1"
        ;;
    "ps57" )
	deb_version="5.7"
	rpm_version="57"
	lib_version="20"
        ;;
    "pxc56" )
	deb_version="5.6"
	rpm_version="56"
        galera_version="3"
        garbd_version="3"
        ;;
    "pxc57" )
	deb_version="5.7"
	rpm_version="57"
        garbd_version="5.7"
        ;;
esac

product=$1

if [ -f /etc/redhat-release ]; then
	rpm -qa | grep Percona

 	if [ "${product}" =  "ps56" -o "${product}" = "ps57" ]; then

		yum remove -y Percona-Server-client-${rpm_version} Percona-Server-server-${rpm_version} Percona-Server-${rpm_version}-debuginfo Percona-Server-devel-${rpm_version} Percona-Server-shared-${rpm_version} Percona-Server-test-${rpm_version}
	rpm -qa | grep Percona

	elif [ "${product}" = "pxc56" -o "${product}" = "pxc57" ]; then
		yum remove -y 'Percona-XtraDB-Cluster-galera-3*' 'Percona-XtraDB-Cluster*' 'Percona-XtraDB-Cluster-garbd-3*'
	else
		echo "product version is incorrect"
		exit 1
	rpm -qa | grep Percona
	fi
else
 	if [ "${product}" =  "ps56" -o "${product}" = "ps57" ]; then
	dpkg -l | grep percona

	apt-get remove -y libperconaserverclient${lib_version} percona-server-${deb_version}-dbg percona-server-client-${deb_version} percona-server-common-${deb_version} percona-server-source-${deb_version} percona-server-test-${deb_version} percona-xtrabackup

	dpkg -l | grep percona
	elif [ "${product}" = "pxc56" ]; then

	apt-get remove -y percona-xtradb-cluster-${deb_version} percona-xtradb-cluster-${deb_version}-dbg percona-xtradb-cluster-client-${deb_version} percona-xtradb-cluster-common-${deb_version} percona-xtradb-cluster-full-${rpm_version} percona-xtradb-cluster-galera-${galera_version} percona-xtradb-cluster-galera-${galera_version}.x percona-xtradb-cluster-galera-${galera_version}.x-dbg percona-xtradb-cluster-galera3-dbg percona-xtradb-cluster-garbd-${garbd_version} percona-xtradb-cluster-garbd-${garbd_version}.x percona-xtradb-cluster-garbd-${garbd_version}.x-dbg percona-xtradb-cluster-server-${deb_version} percona-xtradb-cluster-server-debug-${deb_version} percona-xtradb-cluster-test-${deb_version}

	dpkg -l | grep percona
	elif [ "${product}" = "pxc57" ]; then

	dpkg -l | grep percona
	apt-get remove -y percona-xtradb-cluster-${deb_version}-dbg percona-xtradb-cluster-client-${deb_version} percona-xtradb-cluster-common-${deb_version} percona-xtradb-cluster-full-${rpm_version} percona-xtradb-cluster-garbd-${deb_version} percona-xtradb-cluster-garbd-debug-${deb_version} percona-xtradb-cluster-server-${deb_version} percona-xtradb-cluster-server-debug-${deb_version} percona-xtradb-cluster-test-${deb_version}
	else
		echo "product version is incorrect"
		exit 1
	dpkg -l | grep percona
	fi
fi

ps auxww | grep mysql | grep -v grep

