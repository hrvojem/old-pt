cp /vagrant/percona-dev.repo /etc/yum.repos.d/
rm -rf /etc/yum.repos.d/CentOS-Base.repo
yum install -y python-simplejson.x86_64 vim-enhanced
#wget https://anorien.csc.warwick.ac.uk/mirrors/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivH /vagrant/epel-release-5-4.noarch.rpm
rpm -ivH /vagrant/percona-release-0.1-4.noarch.rpm
yum install -y Percona-Server-shared-compat.x86_64 
