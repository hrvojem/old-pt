#!/bin/bash
sudo apt install git -y
sudo yum install git -y
git clone https://github.com/Percona-QA/package-testing.git
cd package-testing/binary-tarball-tests/ps
export PS_VERSION="8.0.21-12"
export PS_REVISION="e3f3855"
