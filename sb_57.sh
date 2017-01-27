#!/bin/bash
set -e


function clean_db {
    mysql -e "DROP DATABASE IF EXISTS test;"
    mysql -e "CREATE DATABASE test;"
}

function sb_prepare {
    sysbench --test=/usr/share/doc/sysbench/tests/db/parallel_prepare.lua \
         --report-interval=10  \
         --oltp-auto-inc=OFF \
         --mysql-engine-trx=yes \
         --mysql-table-engine=innodb \
         --oltp-table-size=50 \
         --oltp_tables_count=5 \
         --mysql-db=test \
         --db-driver=mysql \
         --mysql-user='root' \
         --mysql-password='U?fY)9s7|3gxUm' \
         prepare 2>&1 | tee /tmp/sysbench_prepare.txt
}

function sb_run {
    sysbench --mysql-table-engine=innodb \
         --num-threads=10 \
         --report-interval=10 \
         --oltp-auto-inc=OFF \
         --max-time=30 \
         --max-requests=1870000000 \
         --test=/usr/share/doc/sysbench/tests/db/oltp.lua \
         --init-rng=on \
         --oltp_index_updates=10 \
         --oltp_non_index_updates=10 \
         --oltp_distinct_ranges=15 \
         --oltp_order_ranges=15 \
         --oltp_tables_count=5 \
         --mysql-db=test \
         --mysql-user='root' \
         --mysql-password='U?fY)9s7|3gxUm' \
         --db-driver=mysql \
         run 2>&1 | tee /tmp/sysbench_rw_run.txt
}

echo "Preparing the sysbench run:"
clean_db
sb_prepare
echo "Running sysbench:"
sb_run


