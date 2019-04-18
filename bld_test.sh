#!/bin/bash


if [ "$(mysql -e "show variables like 'local_infile';" | grep -c OFF)" = 1 ]; then
        echo "local_infile value is correct"
else
        echo "!!!DANGER WILL ROBINSON!!! local_infile value is incorrect"
        exit 1
fi
