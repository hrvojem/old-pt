#!/bin/bash

set -e

psoutput=$(ps auxww | grep -v grep | grep -c /var/lib/proxysql)
echo ${psoutput}

if [ "${psoutput}" != "0" ]; then
	echo "proxysql is running"
   else 
	echo "NOT RUNNING!!!!"
	exit 1
fi
	
