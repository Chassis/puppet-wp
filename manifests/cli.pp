class wp::cli {
	file {'/usr/local/src/wp-cli':
		ensure => directory
	}

	exec {'wget wp-cli.phar':
		command => 'wget http://wp-cli.org/packages/phar/wp-cli.phar',
		path => '/usr/bin',
		cwd => '/usr/local/src/wp-cli',
		creates => '/usr/local/src/wp-cli/wp-cli.phar'
	}

	file {'/usr/bin/wp':
		ensure => file,
		source => '/usr/local/src/wp-cli/wp-cli.phar',
		mode => 'a=rx,ug+w',
		require => Exec[ 'wget wp-cli.phar' ]
	}

	package { 'php5-cli':
		ensure => installed,
	}
}