class wp::cli (
	$ensure = 'installed',
	$install_path = '/usr/local/src/wp-cli',
	$version = 'dev-master'
) {
	$phpprefix = $::operatingsystem ? {
		'RedHat'		=> 'php',
		'CentOS'		=> 'php',
		/^(Debian|Ubuntu)$/	=> 'php5',
		default			=> 'php',
	} 

	if 'installed' == $ensure or 'present' == $ensure {
		# Create the install path
		file { "$install_path":
			ensure => directory,
		}

		# Clone the Git repo
		exec{ 'wp-cli download':
			command => "/usr/bin/curl -o $install_path/wp-cli.phar -L https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar",
			require => [ Package[ 'curl' ], File[ $install_path ] ],
			creates => "$install_path/wp-cli.phar"
		}

		# Ensure we can run the installer
		file { "$install_path/wp-cli.phar":
			ensure => "present",
			mode => "a+x"
		}

		# Install wp-cli
		exec { "wp-cli install":
			command => "/usr/bin/yes | $install_path/wp-cli.phar",
			environment => [
				"VERSION=$version",
				"INSTALL_DIR=$install_path",
				"COMPOSER_HOME=$install_path",

			],
			require => [
				File[ "$install_path/wp-cli.phar" ],
				Package[ 'curl' ],
				Package[ "${phpprefix}-cli" ],
				Package[ 'git' ]
			],
			creates => "$install_path/bin/wp"
		}

		# Ensure we can run wp-cli
		file { "$install_path/bin/wp":
			ensure => "present",
			mode => "a+x",
			require => Exec[ 'wp-cli install' ]
		}

		# Symlink it across
		file { '/usr/bin/wp':
			ensure => link,
			target => "$install_path/bin/wp",
			require => File[ "$install_path/bin/wp" ],
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

	if ! defined(Package["$phpprefix-cli"]) {
		package { "$phpprefix-cli":
			ensure => installed,
		}
	}

	if ! defined(Package['curl']) {
		package { 'curl':
			ensure => installed,
		}
	}

	if ! defined(Package['git']) {
		package { 'git':
			ensure => installed,
		}
	}
}
