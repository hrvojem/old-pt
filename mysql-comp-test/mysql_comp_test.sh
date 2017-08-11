#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
  echo "This script requires product parameter: ps56 or ps57 !"
  echo "Usage: ./comp_test.sh <prod>"
  exit 1
elif [ $1 != "ps56" -a $1 != "ps57" ]; then
  echo "Product not recognized!"
  exit 1
fi

SCRIPT_PWD=$(cd `dirname $0` && pwd)

if [ -f /etc/mysql/my.cnf ]; then
  MYCNF="/etc/mysql/my.cnf"
else
  MYCNF="/etc/my.cnf"
fi

# if the server supports RocksDB options for column families need to be specified before running mysql
if [ $1 = "ps57" ]; then
  service mysql stop
  sleep 10
  echo -e "\n[mysqld]" >> ${MYCNF}
  echo "rocksdb_default_cf_options=compression_per_level=kNoCompression" >> ${MYCNF}
  echo "rocksdb_override_cf_options=cf1={compression_per_level=kZlibCompression};cf2={compression_per_level=kLZ4Compression};cf3={compression_per_level=kZSTDNotFinalCompression}" >> ${MYCNF}
  service mysql start
  sleep 10
fi

tokudb_comp_lib=("no" "zlib" "quicklz" "lzma" "snappy" "dummy")
rocksdb_comp_lib=("no" "zlib" "lz4" "zstd" "dummy")
old="no"
new="no"

mysql -e "DROP DATABASE IF EXISTS comp_test;"
mysql -e "CREATE DATABASE comp_test;"
mysql -e "SET GLOBAL sql_mode = 'TRADITIONAL';"
# needed because of issue in REPEATABLE READ
# ERROR 1105 (HY000) at line 1: Using Gap Lock without full unique key in multi-table or multi-statement transactions is not allowed.
mysql -e "SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;"

secure_file_priv=$(mysql -N -s -e "select @@secure_file_priv;")
if [ -z ${secure_file_priv} ]; then
  secure_file_priv="/tmp/"
fi
rm -f ${secure_file_priv}/t1*.txt
rm -f ${secure_file_priv}/t2*.txt
rm -f ${secure_file_priv}/t3*.txt

for se in TokuDB RocksDB; do
  for comp_lib in no zlib lz4 zstd quicklz lzma snappy dummy; do

    if [[ ${se} = "TokuDB" && " ${tokudb_comp_lib[@]} " =~ " ${comp_lib} " ]] || [[ ${se} = "RocksDB" && " ${rocksdb_comp_lib[@]} " =~ " ${comp_lib} " ]]; then
      if [ $1 = "ps56" -a ${se} = "RocksDB" ]; then
        echo "Skipping RocksDB since not supported in PS 5.6"
      else
        if [ ${comp_lib} != "dummy" ]; then
          old="${new}"
          new="${comp_lib}"
          cat ${SCRIPT_PWD}/create_table.sql > /tmp/create_table.sql
          sed -i "s/@@SE_COMP@@/${se}_${comp_lib}/g" /tmp/create_table.sql
          sed -i "s/@@SE@@/${se}/g" /tmp/create_table.sql
          if [ ${se} = "TokuDB" ]; then
            sed -i "s/ @@COMMENT@@//g" /tmp/create_table.sql
            old_row_format="${new_row_format}"
            if [ ${comp_lib} = "no" ]; then
              new_row_format="ROW_FORMAT=TOKUDB_UNCOMPRESSED"
            elif [ ${comp_lib} = "zlib" ]; then
              new_row_format="ROW_FORMAT=TOKUDB_ZLIB"
            elif [ ${comp_lib} = "quicklz" ]; then
              new_row_format="ROW_FORMAT=TOKUDB_QUICKLZ"
            elif [ ${comp_lib} = "lzma" ]; then
              new_row_format="ROW_FORMAT=TOKUDB_LZMA"
            elif [ ${comp_lib} = "snappy" ]; then
              new_row_format="ROW_FORMAT=TOKUDB_SNAPPY"
            fi
              sed -i "s/ @@ROW_FORMAT_OPT@@/ ${new_row_format}/g" /tmp/create_table.sql
          fi
          if [ ${se} = "RocksDB" ]; then
            sed -i "s/ @@ROW_FORMAT_OPT@@//g" /tmp/create_table.sql
            old_comment="${new_comment}"
            if [ ${comp_lib} = "no" ]; then
              new_comment=""
            elif [ ${comp_lib} = "zlib" ]; then
              new_comment="COMMENT 'cf1'"
            elif [ ${comp_lib} = "lz4" ]; then
              new_comment="COMMENT 'cf2'"
            elif [ ${comp_lib} = "zstd" ]; then
              new_comment="COMMENT 'cf3'"
            fi
            sed -i "s/ @@COMMENT@@/ ${new_comment}/g" /tmp/create_table.sql
          fi

          mysql < /tmp/create_table.sql
        fi

        if [ ${comp_lib} = "no" ]; then
          # insert fresh data into uncompressed tables
          cat ${SCRIPT_PWD}/test_data.sql > /tmp/test_data.sql
          sed -i "s/@@SE@@/${se}/g" /tmp/test_data.sql
          mysql < /tmp/test_data.sql
          for table in t1 t2 t3; do
            mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_${new};" >> /tmp/optimize_table.txt
            mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_${new} INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}.txt';"
          done
        elif [ ${comp_lib} = "dummy" ]; then
          for table in t1 t2 t3; do
            mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no ENGINE=InnoDB ROW_FORMAT=COMPRESSED;"
            mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_no;" >> /tmp/optimize_table.txt
            mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_no INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}_alter_innodb.txt';"
            if [ ${se} = "TokuDB" ]; then
              mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no ENGINE=${se} ${new_row_format};"
            else
              mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no ENGINE=${se};"
            fi
            mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_no;" >> /tmp/optimize_table.txt
            mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_no INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}_alter_back_${se}.txt';"
          done
        else
          for table in t1 t2 t3; do
            mysql -Dcomp_test -e "INSERT INTO ${table}_${se}_${new} SELECT * FROM ${table}_${se}_${old};"
            mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_${new};" >> /tmp/optimize_table.txt
            mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_${new} INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}.txt';"
            if [ ${se} = "TokuDB" ]; then
              mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no ENGINE=TokuDB ${new_row_format};"
              mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_no;" >> /tmp/optimize_table.txt
              mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_no INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}_alter.txt';"
            else
              mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no DROP PRIMARY KEY;"
              mysql -Dcomp_test -e "ALTER TABLE ${table}_${se}_no ADD PRIMARY KEY(a1) ${new_comment};"
              mysql -Dcomp_test -e "OPTIMIZE TABLE ${table}_${se}_no;" >> /tmp/optimize_table.txt
              mysql -Dcomp_test -e "SELECT * FROM ${table}_${se}_no INTO OUTFILE '${secure_file_priv}/${table}_${se}_${new}_alter.txt';"
            fi
          done
        fi

      fi # end for comp_lib
    fi # end for se
  done
done

mysql -e "SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;"

md5sum ${secure_file_priv}/*.txt > /tmp/comp_test_md5.sum


nr1=$(grep -c "e7821682046d961fb2b5ff5d11894491" /tmp/comp_test_md5.sum)
nr2=$(grep -c "3284a0c3a1f439892f6e07f75408b2c2" /tmp/comp_test_md5.sum)
nr3=$(grep -c "72f7e51a16c2f0af31e39586b571b902" /tmp/comp_test_md5.sum)

if [ ${nr1} -ne 20 -o ${nr2} -ne 20 -o ${nr3} -ne 20 ]; then
  echo "md5sums of test files do not match. check files in ${secure_file_priv}"
  exit 1
else
  echo "md5sums of test files match"
  exit 0
fi
