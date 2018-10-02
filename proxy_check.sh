#!/bin/bash

set -e

if [ -f /etc/redhat-release ] && [ "$(grep -c 6 /etc/redhat-release)" -eq 1 ]; then
	psoutput=$(pgrep proxysql | wc -l)
else
	psoutput=$(pgrep -c proxysql)
fi
echo "${psoutput}"

if [ "${psoutput}" -gt 1 ]; then
	echo "proxysql is running"
   else 
	echo "NOT RUNNING!!!!"
	exit 1
fi
	
