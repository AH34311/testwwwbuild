class testwwwbuild::packages {
  $packages = lookup('testwwwbuild::package_list', {
      default_value => [],
  })
  $packages.each |String $package| {
    package { $packages:
      ensure => present,
    }
  }
}
