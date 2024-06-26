# A class to install WP-CLI.
class wp::cli (
	$ensure       = 'installed',
	$install_path = '/usr/local/src/wp-cli',
	$version      = 'dev-master',

) inherits wp {
	if $facts['os']['family'] == 'Windows' {
		Package { provider => 'chocolatey' }
	}

	if 'installed' == $ensure or 'present' == $ensure {
		# Create the install path
		file { [ $install_path, "${install_path}/bin" ]:
			ensure => directory,
		}

		archive { 'wp-cli download':
			ensure => present,
			source => 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar',
			path   => "${install_path}/bin/wp-cli.phar",
		}

		if $facts['kernel'] == 'Linux' {
			file { "${install_path}/bin/${wp::executable_filename}":
				ensure  => 'present',
				content => template('wp/wp.sh.erb'),
				mode    => 'a+x',
				require => Archive[ 'wp-cli download' ]
			}

			# Symlink it across
			file { "${wp::bin_path}/${wp::executable_filename}":
				ensure  => link,
				target  => "${install_path}/bin/${wp::executable_filename}",
				require => File[ "${install_path}/bin/wp" ],
			}
		} else {

			file { "${install_path}/bin/${wp::executable_filename}":
				ensure  => 'present',
				content => template('wp/wp.bat.erb'),
				require => Archive[ 'wp-cli download' ]
			}
		}
	}
	elsif 'absent' == $ensure {
		file { "${wp::bin_path}/${wp::executable_filename}":
			ensure => absent,
		}
		file { '/usr/local/src/wp-cli':
			ensure => absent,
		}
	}

	if $::wp::manage_php_package and ! defined( Package[ $::wp::php_package ] ) {
		package { $::wp::php_package:
			ensure => installed,
		}
	}

	if $::wp::manage_curl_package and ! defined(Package['curl']) {
		package { 'curl':
			ensure => installed,
		}
	}

	if $::wp::manage_git_package and ! defined(Package['git']) {
		package { 'git':
			ensure => installed,
		}
	}
}
