class testwwwbuild::basedirectories {
  $directories = lookup('testwwwbuild::basedirectories', {
    default_value => [],
  })

  $directories.each |Hash $dir| {
    file { $dir['path']:
      ensure => directory,
      owner  => $dir['owner'],
      group  => $dir['group'],
      mode   => $dir['mode'],
    }

  }
}
