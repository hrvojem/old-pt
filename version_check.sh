#!/bin/bash
set -e

version="5.5.50-38.0"
release="38.0"
revision="b05b24c"

log="/tmp/version_check.log"
echo -n > $log

for i in @@INNODB_VERSION @@VERSION ; do
	if [ "$(mysql -e "SELECT $i; "| grep -c $version)" = 1 ]; then
		echo "$i is correct" >> $log
	else
		echo "$i is incorrect"
		exit 1
	fi		
done

if [ "$(mysql -e "SELECT @@VERSION_COMMENT;" | grep $revision | grep -c $release)" = 1 ]; then
	echo "@@VERSION COMMENT is correct" >> $log
else 
	echo "@@VERSION_COMMENT is incorrect"
	exit 1
fi
 
echo "versions are OK"

#@@TOKUDB_VERSION
#mysql -e "SHOW VARIABLES LIKE 'tokudb_backup_plugin_version';"
