class testwwwbuild::basedirectories {
  $basedirectories = lookup('testwwwbuild::basedirectories', {
      default_value => [],
  })

  $basedirectories.each |Hash $dir| {
    file { $dir['path']:
      ensure => directory,
      owner  => $dir['owner'],
      group  => $dir['group'],
      mode   => $dir['mode'],
    }
  }
}
