class wp::cli (
	$ensure = 'installed',
	$install_path = '/usr/local/src/wp-cli',
	$version = 'dev-master'
) {
	if 'installed' == $ensure or 'present' == $ensure {
		# Create the install path
		file { "$install_path":
			ensure => directory,
		}

		# Clone the Git repo
		exec{ 'wp-cli download':
			command => "/usr/bin/curl http://wp-cli.org/installer.sh -o $install_path/installer.sh",
			require => [ Package[ 'curl' ], File[ $install_path ] ],
			creates => "$install_path/installer.sh",
		}

		# Ensure we can run the installer
		file { "$install_path/installer.sh":
			ensure => "present",
			mode => "u+x"
		}

		# Install wp-cli
		exec { "wp-cli install":
			command => "$install_path/installer.sh",
			environment => [
				"VERSION=$version",
				"INSTALL_DIR=$install_path"
			],
			require => [
				File[ "$install_path/installer.sh" ],
				Package[ 'curl' ],
				Package[ 'php5-cli' ]
			],
			creates => "$install_path/wp"
		}

		# Ensure we can run wp-cli
		file { "$install_path/wp":
			ensure => "present",
			mode => "a+x"
		}

		# Symlink it across
		file { '/usr/bin/wp':
			ensure => link,
			target => "$install_path/wp",
			require => File[ "$install_path/wp" ],
		}
	}
	elsif 'absent' == $ensure {
		file { "/usr/bin/wp":
			ensure => absent,
		}
		file { "/usr/local/src/wp-cli":
			ensure => absent,
		}
	}

	package { 'php5-cli':
		ensure => installed,
	}


	package { 'curl':
		ensure => installed,
	}
}