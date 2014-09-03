# = Class: pureftpd
#
# This is the main pureftpd class
#
#
# == Parameters
#
# pureftpd specific parameters
#
# [*storage*]
#   From where userlist will be retreive.
#   Avaliable value are (from now) local and mysql but fell free to extend this
#   module !
#   Default: local
#
# [*mysql_server*]
#   When storage is mysql
#
# [*mysql_database*]
#   The database name used for store pureftpd users.
#
# [*mysql_password*]
#   The pureftpd mysql password (default random).
#
# [*mysql_username*]
#   The pureftpd mysql username.
#
# [*mysql_config_file*]
#   The mysql pureftpd config file.
#
# [*mysql_template*]
#   Template for mysql pureftpd config file.
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, pureftpd class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $pureftpd_myclass
#
# [*source_dir*]
#   If defined, the whole pureftpd configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $pureftpd_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $pureftpd_source_dir_purge
#
# [*service_autorestart*]
#   Automatically restarts the pureftpd service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $pureftpd_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $pureftpd_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $pureftpd_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $pureftpd_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for pureftpd checks
#   Can be defined also by the (top scope) variables $pureftpd_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $pureftpd_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $pureftpd_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $pureftpd_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $pureftpd_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for pureftpd port(s)
#   Can be defined also by the (top scope) variables $pureftpd_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling pureftpd.
#   Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $pureftpd_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $pureftpd_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $pureftpd_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $pureftpd_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in pureftpd::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of pureftpd package
#
# [*service*]
#   The name of pureftpd service
#
# [*service_status*]
#   If the pureftpd service init script supports status argument
#
# [*process*]
#   The name of pureftpd process
#
# [*process_args*]
#   The name of pureftpd arguments. Used by puppi and monitor.
#   Used only in case the pureftpd process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user pureftpd runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $pureftpd_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $pureftpd_protocol
#
#
# See README for usage patterns.
#
class pureftpd (
  $my_class            = params_lookup( 'my_class' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $package_base        = params_lookup( 'package_base' ),
  $package_mysql       = params_lookup( 'package_mysql' ),
  $service             = params_lookup( 'service' ),
  $service_base        = params_lookup( 'service_base' ),
  $service_mysql       = params_lookup( 'service_mysql' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' ),
  $storage             = params_lookup( 'storage' ),
  $mysql_server        = params_lookup( 'mysql_server' ),
  $mysql_database      = params_lookup( 'mysql_database' ),
  $mysql_username      = params_lookup( 'mysql_username' ),
  $mysql_password      = params_lookup( 'mysql_password' ),
  $mysql_config_file   = params_lookup( 'mysql_config_file' ),
  $mysql_template      = params_lookup( 'mysql_template' )
  ) inherits pureftpd::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)

  ### Definition of some variables used in the module
  $manage_package_name = $pureftpd::package ? {
    ''      => $pureftpd::storage ? {
                'file'  => $pureftpd::package_base,
                'mysql' => $pureftpd::package_mysql,
    },
    default => $pureftpd::package,
  }

  $manage_package = $pureftpd::bool_absent ? {
    true  => 'absent',
    false => $pureftpd::version,
  }

  $manage_service_name = $pureftpd::service ? {
    ''      => $pureftpd::storage ? {
                'file'  => $pureftpd::service_base,
                'mysql' => $pureftpd::service_mysql,
    },
    default => $pureftpd::service,
  }

  $manage_service_enable = $pureftpd::bool_disableboot ? {
    true    => false,
    default => $pureftpd::bool_disable ? {
      true    => false,
      default => $pureftpd::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $pureftpd::bool_disable ? {
    true    => 'stopped',
    default =>  $pureftpd::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $pureftpd::bool_service_autorestart ? {
    true    => Service[pureftpd],
    false   => undef,
  }

  $manage_file = $pureftpd::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $pureftpd::bool_absent == true
  or $pureftpd::bool_disable == true
  or $pureftpd::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $pureftpd::bool_absent == true
  or $pureftpd::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $pureftpd::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $pureftpd::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_mysql_password = $pureftpd::mysql_password ? {
    undef   => fqdn_rand(100000000000),
    default => $pureftpd::mysql_password,
  }

  $manage_mysql_config_content = template($pureftpd::mysql_template)

  ### Managed resources
  package { 'pureftpd':
    ensure => $pureftpd::manage_package,
    name   => $pureftpd::manage_package_name,
    noop   => $pureftpd::bool_noops,
  }

  service { 'pureftpd':
    ensure    => $pureftpd::manage_service_ensure,
    name      => $pureftpd::manage_service_name,
    enable    => $pureftpd::manage_service_enable,
    hasstatus => $pureftpd::service_status,
    pattern   => $pureftpd::process,
    require   => Package['pureftpd'],
    noop      => $pureftpd::bool_noops,
  }

  if $pureftpd::storage == 'mysql' {
    file { 'pureftpd-mysql.conf':
      ensure  => $manage_file,
      path    => $pureftpd::mysql_config_file,
      content => $pureftpd::manage_mysql_config_content,
      notify  => $pureftpd::manage_service_autorestart,
      require => Package['pureftpd'],
      replace => $pureftpd::manage_file_replace,
      audit   => $pureftpd::manage_audit,
      noop    => $pureftpd::bool_noops,
    }

    mysql::grant { 'pureftpd':
      mysql_user       => $pureftpd::mysql_username,
      mysql_password   => $pureftpd::manage_mysql_password,
      mysql_db         => $pureftpd::mysql_database,
      mysql_privileges => 'SELECT, INSERT, UPDATE, DELETE, CREATE, DROP',
    }

    mysql::query { 'pureftpd-create-table':
      mysql_query => template('pureftpd/mysql-table-create.sql.erb'),
      mysql_db    => $pureftpd::mysql_database,
      require     => Mysql::Grant['pureftpd'],
    }

    file { '/etc/pure-ftpd/db/65unix':
      ensure => absent,
    }
  }



  # The whole pureftpd configuration directory can be recursively overriden
  if $pureftpd::source_dir {
    file { 'pureftpd.dir':
      ensure  => directory,
      path    => $pureftpd::config_dir,
      require => Package[$pureftpd::package],
      notify  => $pureftpd::manage_service_autorestart,
      source  => $pureftpd::source_dir,
      recurse => true,
      purge   => $pureftpd::bool_source_dir_purge,
      force   => $pureftpd::bool_source_dir_purge,
      replace => $pureftpd::manage_file_replace,
      audit   => $pureftpd::manage_audit,
      noop    => $pureftpd::bool_noops,
    }
  }


  ### Include custom class if $my_class is set
  if $pureftpd::my_class {
    include $pureftpd::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $pureftpd::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'pureftpd':
      ensure    => $pureftpd::manage_file,
      variables => $classvars,
      helper    => $pureftpd::puppi_helper,
      noop      => $pureftpd::bool_noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $pureftpd::bool_monitor == true {
    if $pureftpd::port != '' {
      monitor::port { "pureftpd_${pureftpd::protocol}_${pureftpd::port}":
        protocol => $pureftpd::protocol,
        port     => $pureftpd::port,
        target   => $pureftpd::monitor_target,
        tool     => $pureftpd::monitor_tool,
        enable   => $pureftpd::manage_monitor,
        noop     => $pureftpd::bool_noops,
      }
    }
    if $pureftpd::manage_service_name != '' {
      monitor::process { 'pureftpd_process':
        process  => $pureftpd::process,
        service  => $pureftpd::service,
        pidfile  => $pureftpd::pid_file,
        user     => $pureftpd::process_user,
        argument => $pureftpd::process_args,
        tool     => $pureftpd::monitor_tool,
        enable   => $pureftpd::manage_monitor,
        noop     => $pureftpd::bool_noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $pureftpd::bool_firewall == true and $pureftpd::port != '' {
    firewall { "pureftpd_${pureftpd::protocol}_${pureftpd::port}":
      source      => $pureftpd::firewall_src,
      destination => $pureftpd::firewall_dst,
      protocol    => $pureftpd::protocol,
      port        => $pureftpd::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $pureftpd::firewall_tool,
      enable      => $pureftpd::manage_firewall,
      noop        => $pureftpd::bool_noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $pureftpd::bool_debug == true {
    file { 'debug_pureftpd':
      ensure  => $pureftpd::manage_file,
      path    => "${settings::vardir}/debug-pureftpd",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $pureftpd::bool_noops,
    }
  }

}
