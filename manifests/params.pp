# Class: pureftpd::params
#
# This class defines default parameters used by the main module class pureftpd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to pureftpd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class pureftpd::params {

  ### Application related parameters

  $package = ''
  $package_base = $::operatingsystem ? {
    default => 'pure-ftpd',
  }

  $package_mysql = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'pure-ftpd-mysql',
    default                   => $package_base,
  }

  $service = ''

  $service_base = $::operatingsystem ? {
    default => 'pure-ftpd',
  }

  $service_mysql = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'pure-ftpd-mysql',
    default                   => $service_base,
  }


  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'pure-ftpd',
  }

  $process_mysql = $::operatingsystem ? {
    default => 'pure-ftpd-mysql',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'root',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/pure-ftpd/',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/pure-ftpd-common',
    default                   => '/etc/sysconfig/pureftpd',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/pure-ftpd/pure-ftpd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/pure-ftpd',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/pure-ftpd',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/pure-ftpd/transfer.log',
  }

  $port = '21'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

  ### Specific parameters
  $storage = 'file'
  $mysql_server = '127.0.0.1'
  $mysql_database = 'pureftpd'
  $mysql_username = 'pureftpd'
  $mysql_password = undef
  $mysql_config_file = $::operatingsystem ? {
    default => '/etc/pure-ftpd/db/mysql.conf',
  }
  $mysql_template = 'pureftpd/mysql.conf.erb'


}
