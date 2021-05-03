#!/bin/bash
TARBALL="Percona-XtraDB-Cluster-5.6.51-rel91.0-28.46.1.Linux.x86_64.ssl100"
MIN_TARBALL="Percona-Server-5.7.31-34-Linux.x86_64.glibc2.12-minimal.tar.gz"

echo "RUNNING TARBALL TESTS"
mkdir -p /test-bin/
rsync -avPr /vagrant/${TARBALL} /test-bin/


echo "RUNNING MINIMAL TARBALL TESTS"
rsync -avPr /vagrant/${MIN_TARBALL} /test-bin/
