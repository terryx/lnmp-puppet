# Before we download any package we want to make sure to get latest version of them
# this is equal to execute command apt-get update from the path usr/bin
exec { 'apt-get update':
	path => '/usr/bin'
}

#install vim is optional
package { 'vim':
	ensure => 'present'
}

# create a directory to put our laravel files
file { '/var/www/laravel':
	ensure => 'directory',
	mode => 755
}

# now we need to include our modules
include nginx, php, mysql