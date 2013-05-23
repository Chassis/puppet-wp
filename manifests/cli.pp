class wp::cli (
	$ensure = 'installed',
	$install_path = '/usr/local/src/wp-cli',
) {

	if 'installed' == $ensure or 'present' == $ensure {
		# Clone the Git repo
		exec{ 'git clone wp-cli':
			command => "/usr/bin/git clone --recursive git://github.com/wp-cli/wp-cli.git $install_path",
			before => Exec[ 'wp-cli dev-build' ],
			require => Package[ 'git' ],
			creates => "$install_path",
		}
		# Install composer if needed, run 'composer install', and set up sym link
		exec { 'wp-cli dev-build':
			cwd => "$install_path", # wp-cli expects to be installed from pwd
			command => "/bin/bash $install_path/utils/dev-build",
			require => [ Exec[ 'git clone wp-cli' ], Package['curl'] ],
			creates => '/usr/bin/wp',
		}
	}

	package { 'php5-cli':
		ensure => installed,
	}

	package { 'git': 
		ensure => installed,
	}

	package { 'curl':
		ensure => installed,
	}
}