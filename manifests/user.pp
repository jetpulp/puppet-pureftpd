# = Define: pureftpd::user
#
# Create a new pureftpd user
#
# == Parameters
#
# [*ensure*]
#  Set to absent to remove the ftp user.
#  Default : 'present'
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
  $ensure = 'present',
  $username = $name,
  $home     = "/home/${name}"
) {
  include pureftpd

  $manage_mysql_query_template = $ensure ? {
    'absent' => 'pureftpd/mysql-user-delete.sql.erb',
    default  => 'pureftpd/mysql-user-create.sql.erb',
  }

  if $pureftpd::storage == 'mysql' {
    mysql::query { "pureftpd-create-user-${username}":
      mysql_query => template($manage_mysql_query_template),
      mysql_db    => $pureftpd::mysql_database,
    }
  }
}
