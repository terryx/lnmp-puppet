class mysql {
	$password = 'terryisawesome'

	package { 'mysql-server':
		ensure => 'present',
		require => Exec['apt-get update']
	}

	#make sure mysql is running
	service { 'mysql':
		ensure => 'running',
		hasrestart => true,
		require => Package['mysql-server']
	}

	# Use a custom mysql configuration file so you configure easier in future
  	file { '/etc/mysql/my.cnf':
    	source  => 'puppet:///modules/mysql/my.cnf',
    	require => Package['mysql-server'],
    	notify  => Service['mysql'],
  	}

  	# It is recommend to set a password access
  	exec { 'set-mysql-password':
    	unless  => 'mysqladmin -uroot -p$password status',
    	refreshonly => true,
    	command => "mysqladmin -uroot password $password",
    	path    => '/bin:/usr/bin',
    	subscribe => Package['mysql-server']
  	}

}