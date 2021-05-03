#!/bin/bash
log="/tmp/binary_check.log"
#arball_dir="Percona-XtraDB-Cluster-5.6.51-rel91.0-28.46.1.Linux.x86_64.ssl1c7"
#arball_dir="Percona-XtraDB-Cluster_8.0.22-13.1_Linux.x86_64.glibc2.17"
tarball_dir="Percona-XtraDB-Cluster-5.7.33-rel36-49.1.Linux.x86_64.glibc2.12"

pxc56="clustercheck myisam_ftdump mysqlaccess mysqlcheck mysqld mysql_find_rows mysql_secure_installation mysql_tzinfo_to_sql pyclustercheck wsrep_sst_mysqldump garbd myisamlog mysqlaccess.conf mysql_client_test mysqld_multi mysql_fix_extensions mysql_setpermission mysql_upgrade replace wsrep_sst_rsync innochecksum myisampack mysqladmin mysql_config mysqld_safe mysqlhotcopy mysqlshow mysql_waitpid resolveip wsrep_sst_xtrabackup msql2mysql my_print_defaults mysqlbinlog mysql_config_editor mysqldump mysqlimport mysqlslap mysql_zap resolve_stack_dump  wsrep_sst_xtrabackup-v2 myisamchk mysql mysqlbug mysql_convert_table_format mysqldumpslow mysql_plugin mysqltest perror wsrep_sst_common"

pxc57="clustercheck myisamchk my_print_defaults mysqlcheck mysqld mysqldumpslow mysqlpump mysql_ssl_rsa_setup mysqlxtest ps_tokudb_admin resolve_stack_dump wsrep_sst_xtrabackup-v2 garbd myisam_ftdump mysql mysql_client_test mysqld_multi mysqlimport mysql_secure_installation mysqltest perror pyclustercheck wsrep_sst_common zlib_decompress innochecksum myisamlog mysqladmin mysql_config mysqld_safe mysql_install_db mysqlshow mysql_tzinfo_to_sql ps-admin replace wsrep_sst_mysqldump lz4_decompress myisampack mysqlbinlog mysql_config_editor mysqldump mysql_plugin mysqlslap mysql_upgrade ps_mysqld_helper resolveip wsrep_sst_rsync"

pxc80=""

exec_files="${pxc57}"
## grabd ERROR in stretch/bionic
#exec_files="clustercheck myisam_ftdump mysqlaccess mysqlcheck mysqld mysql_find_rows mysql_secure_installation mysql_tzinfo_to_sql pyclustercheck wsrep_sst_mysqldump myisamlog mysqlaccess.conf mysql_client_test mysqld_multi mysql_fix_extensions mysql_setpermission mysql_upgrade replace wsrep_sst_rsync innochecksum myisampack mysqladmin mysql_config mysqld_safe mysqlhotcopy mysqlshow mysql_waitpid resolveip wsrep_sst_xtrabackup msql2mysql my_print_defaults mysqlbinlog mysql_config_editor mysqldump mysqlimport mysqlslap mysql_zap resolve_stack_dump  wsrep_sst_xtrabackup-v2 myisamchk mysql mysqlbug mysql_convert_table_format mysqldumpslow mysql_plugin mysqltest perror wsrep_sst_common"

echo "Check symlinks for all executables" >> "${log}"
for binary in $exec_files; do
    if [ -f ${tarball_dir}/bin/${binary} ]; then
       echo "Check ${tarball_dir}/bin/${binary}" >> "${log}"
       ldd ${tarball_dir}/bin/${binary} | grep "not found"
       if [ "$?" -eq 0 ]; then
          echo "Err: Binary $binary in version ${version} has an incorrect linked library"
          exit 1
       else
          echo "Binary $binary check passed" >> "${log}"
       fi
    else
       echo "Err: The binary ${tarball_dir}/bin/${binary} was not found"
       exit 1
    fi
done
