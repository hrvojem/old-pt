#!/bin/bash

set -e

if [ "$(mysql -e "show variables like 'bind_address';" | grep -c 127.0.0.1)" = 1 ]; then
    echo "bind-address is correct"
else
    echo "!!!DANGER WILL ROBINSON!!! bind-address is incorrect"
    exit 1
fi

if [ "$(mysql -e "show variables like 'local_infile';" | grep -c OFF)" = 1 ]; then
        echo "local_infile value is correct"
else
        echo "!!!DANGER WILL ROBINSON!!! local_infile value is incorrect"
        exit 1
fi
