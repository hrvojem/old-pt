#!/bin/bash
set -e
mysql -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'"
mysql -e "INSTALL PLUGIN auth_pam SONAME 'auth_pam.so';"
# disabled due to https://jira.percona.com/browse/PS-4853
#mysql -e "INSTALL PLUGIN audit_log SONAME 'audit_log.so';"
#mysql -e "INSTALL PLUGIN mysqlx SONAME 'mysqlx.so';"
mysql -e "INSTALL PLUGIN keyring_vault SONAME 'keyring_vault.so';"
mysql -e "SHOW PLUGINS;"
mysql -e "CREATE DATABASE world;"
mysql -e "CREATE DATABASE world2;"
pv /vagrant/world_innodb.sql | mysql -D world
pv /vagrant/world_innodb.sql | mysql -D world2
mysql < /vagrant/tokudb_compression.sql
