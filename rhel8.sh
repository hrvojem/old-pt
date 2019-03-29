#!/bin/bash

if [ -f /etc/redhat-release ] && [ "$(grep -c Red /etc/redhat-release)" == 1 ]; then
  echo "This is RHEL8"
  curl -o /etc/yum.repos.d/percona-dev.repo https://jenkins.percona.com/yum-repo/rhel8/rhel8-beta.repo
  yum install -y python3 python3-dnf 
  ln -s /usr/bin/python3 /usr/bin/python
else
  echo "Not RHEL; nothing to do here"
fi
