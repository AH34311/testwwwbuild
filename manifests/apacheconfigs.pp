class testwwwbuild::apacheconfigs {
  file { '/etc/httpd/conf.d':
    ensure => directory,
  }
  $vhosts = lookup('testwwwbuild::vhosts', {
      default_value => {},
  })

  $vhosts.each |String $conf, Hash $params| {
    file { "/etc/httpd/conf.d/${conf}.conf":
      ensure  => file,
      source  => "puppet:///modules/apache_vhosts/vhosts/${conf}.conf",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      seltype => 'httpd_config_t',
      notify  => Service['httpd'],
    }
    file { "/var/log/httpd/${conf}":
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }
  $maps = lookup('testwwwbuild::maps', {
      default_value => {},
  })

  $maps.each |String $map, Hash $params| {
    file { "/etc/httpd/maps/${map}.txt":
      ensure  => file,
      source  => "puppet:///modules/testwwwbuild/maps/${map}.txt",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      seltype => 'httpd_config_t',
      notify  => Service['httpd'],
    }
  }
}
