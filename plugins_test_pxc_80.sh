#!/bin/bash
set -e
WARNINGS_BEFORE=0
WARNINGS_AFTER=0
ERROR_LOG=""
ERROR_LOG=$(mysql -N -s -e "show variables like 'log_error';" | grep -v "Warning:" | grep -o "\/.*$")
if [ ! -f ${ERROR_LOG} ]; then
  echo "Error log was not found!"
  exit 1
fi

echo "1"
WARNINGS_BEFORE=$(grep -c "\[Warning\]" ${ERROR_LOG} || true)
ERRORS_BEFORE=$(grep -c "\[ERROR\]" ${ERROR_LOG} || true)

mysql -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'"
mysql -e "INSTALL PLUGIN audit_log SONAME 'audit_log.so';"
mysql -e "CREATE FUNCTION version_tokens_set RETURNS STRING SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_show RETURNS STRING SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_edit RETURNS STRING SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_delete RETURNS STRING SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_lock_shared RETURNS INT SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_lock_exclusive RETURNS INT SONAME 'version_token.so';"
mysql -e "CREATE FUNCTION version_tokens_unlock RETURNS INT SONAME 'version_token.so';"
mysql -e "INSTALL PLUGIN mysql_no_login SONAME 'mysql_no_login.so';"
mysql -e "CREATE FUNCTION service_get_read_locks RETURNS INT SONAME 'locking_service.so';"
mysql -e "CREATE FUNCTION service_get_write_locks RETURNS INT SONAME 'locking_service.so';"
mysql -e "CREATE FUNCTION service_release_locks RETURNS INT SONAME 'locking_service.so';"
#mysql -e "INSTALL PLUGIN validate_password SONAME 'validate_password.so';"
mysql -e "INSTALL PLUGIN version_tokens SONAME 'version_token.so';"
mysql -e "INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';"
mysql -e "INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';"
mysql -e "INSTALL PLUGIN connection_control SONAME 'connection_control.so';"
mysql -e "INSTALL PLUGIN connection_control_failed_login_attempts SONAME 'connection_control.so';"
#mysql -e "INSTALL PLUGIN authentication_ldap_simple SONAME 'authentication_ldap_simple.so';"

#for component in component_validate_password component_log_sink_syseventlog component_log_sink_json component_log_filter_dragnet component_audit_api_message_emit; do
# if [ $(mysql -Ns -e "select count(*) from mysql.component where component_urn=\"file://${component}\";") -eq 0 ]; then
#  mysql -e "INSTALL COMPONENT \"file://${component}\";"
#fi
#if [ $(mysql -Ns -e "select count(*) from mysql.component where component_urn=\"file://${component}\";") -ne 1 ]; then
#  echo "MySQL Component ${component} failed to install!"
#  exit 1
#fi
#done

mysql -e "SHOW PLUGINS;"
mysql -e "CREATE DATABASE sbt;"
mysql -e "CREATE DATABASE sbtest;"
mysql -e "CREATE DATABASE world;"

mysql  -e "CREATE USER sysbench@'%' IDENTIFIED WITH mysql_native_password BY 'test';"
mysql  -e "GRANT ALL ON *.* TO sysbench@'%';"

sed -i '18,21 s/^/-- /' /vagrant/world_innodb.sql
pv /vagrant/world_innodb.sql | mysql -D world
if [ ! -z "$1" ]; then
  if [ "$1" = "ps" ]; then
    mysql -e "CREATE DATABASE sbt;"
  fi
fi

#ERRORS_AFTER=$(grep -c "\[ERROR\]" ${ERROR_LOG} || true)
ERRORS_AFTER=$(grep "\[ERROR\]" ${ERROR_LOG} | grep -v "keyring_vault" -c || true) 
if [ "${ERRORS_BEFORE}" != "${ERRORS_AFTER}" ]; then
  echo "There's a difference in number of errors before installing plugins and after!"
  exit 1
fi

WARNINGS_AFTER=$(grep -c "\[Warning\]" ${ERROR_LOG} || true)
if [ "${WARNINGS_BEFORE}" != "${WARNINGS_AFTER}" ]; then
  echo "There's a difference in number of warnings before installing plugins and after!"
  exit 1
fi
