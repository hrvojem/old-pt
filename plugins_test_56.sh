#!/bin/bash
set -e
mysql -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'"
mysql -e "INSTALL PLUGIN auth_pam SONAME 'auth_pam.so';"
mysql -e "INSTALL PLUGIN audit_log SONAME 'audit_log.so';"
mysql -e "INSTALL PLUGIN handlersocket SONAME 'handlersocket.so';"
mysql -e "INSTALL PLUGIN QUERY_RESPONSE_TIME_AUDIT SONAME 'query_response_time.so';"
mysql -e "INSTALL PLUGIN QUERY_RESPONSE_TIME SONAME 'query_response_time.so';"
mysql -e "INSTALL PLUGIN QUERY_RESPONSE_TIME_READ SONAME 'query_response_time.so';"
mysql -e "INSTALL PLUGIN QUERY_RESPONSE_TIME_WRITE SONAME 'query_response_time.so';"
mysql -e "INSTALL PLUGIN scalability_metrics SONAME 'scalability_metrics.so';"
mysql -e "INSTALL PLUGIN connection_control SONAME 'connection_control.so';"
mysql -e "SHOW PLUGINS;"
mysql -e "CREATE DATABASE sbt;"
mysql -e "CREATE DATABASE world;"
mysql -e "CREATE DATABASE world2;"
cat /vagrant/world_innodb.sql | mysql -D world
cat /vagrant/world_innodb.sql | mysql -D world2
mysql < /vagrant/tokudb_compression.sql
