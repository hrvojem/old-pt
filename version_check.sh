#!/bin/bash
set -e
mysql -e "SELECT @@INNODB_VERSION;" 
mysql -e "SELECT @@VERSION;" 
mysql -e "SELECT @@VERSION_COMMENT;" 
mysql -e "SHOW VARIABLES LIKE 'tokudb_backup_plugin_version';"
mysql -e "SHOW STATUS LIKE 'wsrep_provider_version';"
#mysql -e "SELECT @@TOKUDB_VERSION;"
