# A class to install WP-CLI.
class wp::cli (
	$ensure       = 'installed',
	$install_path = '/usr/local/src/wp-cli',
	$version      = 'dev-master',

) {
  if $::osfamily == 'Windows' {
    Package { provider => 'chocolatey' }
  }

	include wp

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

		if $::kernel == 'Linux' {
      file { "${install_path}/bin/wp":
        ensure  => 'present',
        source  => 'puppet:///modules/wp/wp',
        mode    => 'a+x',
        require => Archive[ 'wp-cli download' ]
      }

      # Symlink it across
      file { "${wp::params::bin_path}/wp":
        ensure  => link,
        target  => "${install_path}/bin/wp",
        require => File[ "${install_path}/bin/wp" ],
      }
    } else {
      
      file { "${install_path}/bin/wp.bat":
        ensure  => 'present',
        source  => 'puppet:///modules/wp/wp.bat',
        require => Archive[ 'wp-cli download' ]
      }
    }
	}
	elsif 'absent' == $ensure {
		file { "${wp::params::bin_path}/wp":
			ensure => absent,
		}
		file { '/usr/local/src/wp-cli':
			ensure => absent,
		}
	}

	if ! defined( Package[ $::wp::php_package ] ) {
		package { $::wp::php_package:
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
