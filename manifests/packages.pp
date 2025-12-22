class testwwwbuild::packages {
  $packages = lookup('testwwwbuild::package_list', {
      default_value => [],
  })
  package { $packages:
    ensure => present,
  }
}
