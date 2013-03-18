class wp::cli {
	if ! defined(Package['git-core']) {
		package {'git-core':
			ensure => installed,
		}
	}

	file {'/usr/local/src/wp-cli':
		ensure => directory
	}

	exec {'git clone wp-cli':
		command => '/usr/bin/git clone --recursive git://github.com/wp-cli/wp-cli.git .',
		cwd => "/usr/local/src/wp-cli",
		creates => "/usr/local/src/wp-cli/.git",
		#onlyif => '/usr/bin/test ! -d /usr/local/src/wp-cli/.git',
		require => [ File['/usr/local/src/wp-cli'], Package['git-core'] ]
	}

	exec {'wp-cli/utils/dev-build':
		command => '/usr/local/src/wp-cli/utils/dev-build',
		cwd => '/usr/local/src/wp-cli',
		creates => "/usr/bin/wp",
		require => Exec['git clone wp-cli']
	}
}