class testwwwbuild::cron {
  $crons = lookup('testwwwbuild::crons', {
      default_value => {},
  })

  $crons.each |String $name, Hash $job| {
    cron { $name:
      command => $job['command'],
      user    => $job['user'],
      hour    => $job['hour'],
      minute  => $job['minute'],
    }
  }
}
