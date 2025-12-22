class testwwwbuild::logrotation {
  file { '/etc/logrotate.d/httpd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('testwwwbuild/httpd.erb'),
  }
}
