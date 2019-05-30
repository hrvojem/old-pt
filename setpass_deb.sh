#!/bin/bash
set -e

mysql -uroot -e "UPDATE mysql.user SET authentication_string = PASSWORD('U?fY)9s7|3gxUm') WHERE User = 'root' AND Host = 'localhost';"

cp /vagrant/templates/my_57.j2 /root/.my.cnf
