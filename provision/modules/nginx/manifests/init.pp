class nginx {
	
	#install nginx after apt-get update
	package { 'nginx':
		ensure => "present",
		require => Exec["apt-get update"]
	}

	#make sure nginx is running
 	service { 'nginx':
		ensure => 'running',
		require => Package['nginx']
	}

	#change vhost settings
	file { "vhost":
		path => '/etc/nginx/sites-available/default',
		ensure => 'present',
		require => Package['nginx'],
		source => "puppet:///modules/nginx/default",
		group => 'root',
		notify => Service["nginx"]
	 }
}