class php {

  #install php packages, laravel require mcrypt
  package { ['php5-fpm', 'php5-cli', 'php5-mcrypt']:
    ensure => 'present',
    require => Exec['apt-get update']
  }

  #ensure php5-fpm is running
  service { 'php5-fpm':
    ensure => 'running',
    require => Package['php5-fpm']
  }

  #custom php.ini settings that make laravel work
  file { '/etc/php5/fpm/php.ini':
    require => Package['php5-mcrypt'],
    source => 'puppet:///modules/php/php.ini',
    owner => 'root',
    group => 'root',
    notify => Service['php5-fpm']
  }

}