#!/bin/bash

if [ -z "$1" ]; then
  echo "This script needs parameter default|file|symlink"
  exit 1
elif [ "$1" != "default" -a "$1" != "file" -a "$1" != "symlink" ]; then
  echo "Invalid option!"
  exit 1
else
  OPTION="$1"
fi

function check_default {
  if [ -f /etc/debian_version ]; then
    echo " this is debian/ubuntu"
    echo "#this is test" >> /etc/mysql/my.cnf
    md5sum /etc/mysql/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  else
    echo " this is centos"
    echo "#this is test" >> /etc/my.cnf
    md5sum /etc/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  fi  
}

function check_file {
  if [ -f /etc/debian_version ]; then
    echo " this is debian/ubuntu"
    rm -rf /etc/mysql/my.cnf
    cp -pvr /vagrant/deb.cnf /etc/mysql/my.cnf
    md5sum /etc/mysql/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  else
    echo " this is centos"
    rm -rf /etc/my.cnf
    cp -pvr /vagrant/rpm.cnf /etc/my.cnf
    md5sum /etc/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  fi
}

function check_symlink {
  if [ -f /etc/debian_version ]; then
    echo " this is debian/ubuntu"
    rm -rf /etc/mysql/my.cnf
    cp -pvr /vagrant/deb.cnf /etc/mysql/percona.cnf
    ln -s /etc/mysql/percona.cnf /etc/mysql/my.cnf
    md5sum /etc/mysql/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  else
    echo " this is centos"
    rm -rf /etc/my.cnf
    cp -pvr /vagrant/rpm.cnf /etc/percona.cnf
    ln -s /etc/percona.cnf /etc/my.cnf
    md5sum /etc/my.cnf | awk {'print $1'} > /tmp/mycnf_sum
  fi
}

if [ "$OPTION" == "default" ]; then
  check_default
elif [ "$OPTION" == "file" ]; then
  check_file
elif [ "$OPTION" == "symlink" ]; then
  check_symlink
else
  echo "invalid option"
  exit 1
fi


