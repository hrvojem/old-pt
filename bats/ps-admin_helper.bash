MYSQL_VERSION=$(mysqld --version|grep -o "[0-9]\.[0-9]")
if [ -S /run/mysqld/mysqld.sock ]; then
  CONNECTION=${CONNECTION:--S/run/mysqld/mysqld.sock}
else
  CONNECTION=${CONNECTION:--S/var/lib/mysql/mysql.sock}
fi
PS_ADMIN_BIN=${PS_ADMIN_BIN:-/usr/bin/ps-admin}

install_qrt() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-qrt"
  [ $status -eq 0 ]
}

uninstall_qrt() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-qrt"
  [ $status -eq 0 ]
}

check_qrt_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "QUERY_RESPONSE_TIME%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 4 ]
}

check_qrt_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "QUERY_RESPONSE_TIME%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_audit() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-audit"
  [ $status -eq 0 ]
}

check_audit_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "audit_log%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 1 ]
}

uninstall_audit() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-audit"
  [ $status -eq 0 ]
}

check_audit_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "audit_log%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_pam() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-pam"
  [ $status -eq 0 ]
}

check_pam_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "auth_pam%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 1 ]
}

uninstall_pam() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-pam"
  [ $status -eq 0 ]
}

check_pam_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "auth_pam%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_mysqlx() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-mysqlx"
  [ $status -eq 0 ]
}

check_mysqlx_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "mysqlx%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 1 ]
}

uninstall_mysqlx() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-mysqlx"
  [ $status -eq 0 ]
}

check_mysqlx_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "mysqlx%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_tokudb() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-tokudb"
  [ $status -eq 0 ]

  service mysql restart >/dev/null 3>&-
  [ $? -eq 0 ]
  sleep 5

  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-tokudb"
  [ $status -eq 0 ]
}

check_tokudb_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.ENGINES where ENGINE="TokuDB" and SUPPORT <> "NO";')
  [ "$result" -eq 1 ]

  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like BINARY "%TokuDB%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 8 ]
}

uninstall_tokudb() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-tokudb"
  [ $status -eq 0 ]
}

check_tokudb_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.ENGINES where ENGINE="TokuDB" and SUPPORT <> "NO";')
  [ "$result" -eq 0 ]

  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "%tokudb%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_tokubackup() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-tokubackup"
  [ $status -eq 0 ]

  service mysql restart >/dev/null 3>&-
  [ $? -eq 0 ]
  sleep 5

  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-tokubackup"
  [ $status -eq 0 ]
}

check_tokubackup_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "%tokudb_backup%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 1 ]
}

uninstall_tokubackup() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-tokubackup"
  [ $status -eq 0 ]
}

check_tokubackup_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "%tokudb_backup%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_rocksdb() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-rocksdb"
  [ $status -eq 0 ]
}

check_rocksdb_exists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.ENGINES where ENGINE="ROCKSDB" and SUPPORT <> "NO";')
  [ "$result" -eq 1 ]

  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like BINARY "%ROCKSDB%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 12 ]
}

uninstall_rocksdb() {
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-rocksdb"
  [ $status -eq 0 ]
}

check_rocksdb_notexists() {
  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.ENGINES where ENGINE="ROCKSDB" and SUPPORT <> "NO";')
  [ "$result" -eq 0 ]

  result=$(mysql ${CONNECTION} -N -s -e 'select count(*) from information_schema.PLUGINS where PLUGIN_NAME like "%ROCKSDB%" and PLUGIN_STATUS like "ACTIVE";')
  [ "$result" -eq 0 ]
}

install_all() {
  if [ ${MYSQL_VERSION} = "5.5" ]; then
    OPT=""
  elif [ ${MYSQL_VERSION} = "5.6" ]; then
    OPT="--enable-tokudb --enable-tokubackup"
  else
    OPT="--enable-mysqlx --enable-tokudb --enable-tokubackup --enable-rocksdb"
  fi
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-qrt --enable-audit --enable-pam ${OPT}"
  [ $status -eq 0 ]

  service mysql restart >/dev/null 3>&-
  [ $? -eq 0 ]
  sleep 5

  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --enable-qrt --enable-audit --enable-pam ${OPT}"
  [ $status -eq 0 ]
}

uninstall_all() {
  if [ ${MYSQL_VERSION} = "5.5" ]; then
    OPT=""
  elif [ ${MYSQL_VERSION} = "5.6" ]; then
    OPT="--disable-tokudb --disable-tokubackup"
  else
    OPT="--disable-mysqlx --disable-tokudb --disable-tokubackup --disable-rocksdb"
  fi
  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-qrt --disable-audit --disable-pam ${OPT}"
  [ $status -eq 0 ]

  service mysql restart >/dev/null 3>&-
  [ $? -eq 0 ]
  sleep 5

  run bash -c "${PS_ADMIN_BIN} ${CONNECTION} --disable-qrt --disable-audit --disable-pam ${OPT}"
  [ $status -eq 0 ]
}
