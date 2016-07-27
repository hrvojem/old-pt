#!/bin/bash

set -e

version="5.6.30-25.16.1"
rpm_version="56"
galera="3.16-1"
log="/tmp/pxc_run.log"
#echo -n > /tmp/pxb_run.log

echo "checking if all packages are installed"
if [ -f /etc/redhat-release ]; then
        if [ "$(rpm -qa | grep Percona-XtraDB-Cluster | grep -c ${version})" == "6" ]; then
                echo "all packages are installed"
        else
                for package in Percona-XtraDB-Cluster-devel-${rpm_version} Percona-XtraDB-Cluster-test-${rpm_version} Percona-XtraDB-Cluster-${rpm_version}-debuginfo Percona-XtraDB-Cluster-server-${rpm_version} Percona-XtraDB-Cluster-galera-3-debuginfo Percona-XtraDB-Cluster-client-${rpm_version} Percona-XtraDB-Cluster-galera-3-3.16-1 Percona-XtraDB-Cluster-shared-${rpm_version} Percona-XtraDB-Cluster-garbd-3-3.16-1 Percona-XtraDB-Cluster-full-${rpm_version}; do
                        if [ "$(rpm -qa | grep -c ${package}-${version})" -gt 0 ]; then
                                echo "$(date +%Y%m%d%H%M%S): ${package} is installed" >> ${log}
                        else
                                echo "WARNING: ${package}-${version} is not installed"
                        fi
                done
        fi
else
        if [ "$(dpkg -l | grep percona | grep -c ${version})" == "6" ]; then
                echo "all packages are installed"
        else
                for package in percona-xtrabackup-dbg percona-xtrabackup-test percona-xtrabackup; do
                        if [ "$(dpkg -l | grep -c ${package})" -gt 0 ] && [ "$dpkg -l | grep ${package} | awk '{$print $3}' == $version.$(lsb_release -sc)" ] ; then
                                echo "$(date +%Y%m%d%H%M%S): ${package} is installed" >> ${log}
                        else
                                echo "WARNING: ${package}-${version} is not installed"
                        fi
                done
        fi
fi

