class testwwwbuild::basesymlinks {
  $symlinks = lookup('testwwwbuild::basesymlinks', {
      default_value => [],
  })

  $symlinks.each |Hash $link| {
    file { $link['path']:
      ensure => link,
      target => $link['target'],
    }
  }
}
