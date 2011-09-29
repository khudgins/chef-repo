name "mysql_server"
description "Mysql server."
run_list(
  'recipe[mysql::server]'
)