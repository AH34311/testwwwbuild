class testwwwbuild::apacheconfigs {
  file { '/etc/httpd/conf.d':
    ensure => directory,
  }
  $vhosts = lookup('apacheconfigs::vhosts', {
      default_value => {},
  })

  $vhosts.each |String $conf, Hash $opts| {
    file { "/etc/httpd/conf.d/${conf}":
      source => "puppet:///modules/testwwwbuild/vhosts/${conf}",
      notify => Service['httpd'],
    }
    file { "/var/log/httpd/${conf}":
      ensure => directory,
    }
  }
}
