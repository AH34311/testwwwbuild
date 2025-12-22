class testwwwbuild::basedirectories {
  $directories = lookup('testwwwbuild::directories', {
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
