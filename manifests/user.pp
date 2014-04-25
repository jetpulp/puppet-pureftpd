# = Define: pureftpd::user
#
# Create a new pureftpd user
#
# == Parameters
#
# [*username*]
#
# [*password*]
#
# [*home*]
#
# [*uid*]
#
# [*gid*]
#
define pureftpd::user (
  $password,
  $uid,
  $gid,
  $username = $name,
  $home     = "/home/$name"
) {
  include pureftpd

  if $pureftpd::storage == 'mysql' {
    mysql::query { "pureftpd-create-user-${username}":
      mysql_query => template('pureftpd/mysql-user-create.sql.erb'),
      mysql_db    => $pureftpd::mysql_database,
    }
  }
}
