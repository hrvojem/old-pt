echo "===== MYSQL ====="; ps aux|grep "mysqld "|grep -v grep; echo -e "\n===== MONGODB ====="; ps aux|grep "mongod "|grep -v grep; echo -e "\n===== VAULT ====="; ps aux|grep "vault "|grep -v grep
