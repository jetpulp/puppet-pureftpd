# Define:: pureftpd::config_option
#
#
define pureftpd::config_option (
  $value,
  $config_name = $name,
) {

  include pureftpd

  $manage_config_file_path = "${pureftpd::config_dir}/conf/${config_name}"

  file { "pureftpd-config_option-${name}":
    path    => $manage_config_file_path,
    content => $value,
    require => Package['pureftpd'],
    notify  => $pureftpd::manage_service_autorestart,
    replace => $pureftpd::manage_file_replace,
    audit   => $pureftpd::manage_audit,
    noop    => $pureftpd::bool_noops,
  }


} # Class:: pureftpd::config_option
