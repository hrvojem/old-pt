#!/bin/bash
set -e
mysql -e "CREATE DATABASE world;"
cat /vagrant/world_innodb.sql | mysql -D world
