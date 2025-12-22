class testwwwbuild::packages {
  $base_packages = ['telnet','unzip','wget','postfix']
  package { $base_packages:
    ensure => 'present',
  }
}
