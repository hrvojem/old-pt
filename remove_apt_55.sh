#!/bin/bash
set -e

dpkg -l | grep percona

apt-get remove libperconaserverclient18 percona-server-5.5-dbg percona-server-client-5.5 percona-server-common-5.5 percona-server-source-5.5 percona-server-test-5.5 percona-xtrabackup -y

dpkg -l | grep percona
