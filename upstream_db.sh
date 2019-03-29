#!/bin/bash
set -e
mysql -e "CREATE DATABASE worlds;"
cat /vagrant/world_innodb.sql | mysql -D worlds
