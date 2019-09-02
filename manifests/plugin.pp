# A class for WP-CLI's plugin commands.
define wp::plugin (
	$location,
	$slug = $title,
	$ensure = enabled,
	$networkwide = false,
	$version = 'latest',
) {
	include wp::cli

	if ( $networkwide ) {
		$network = ' --network'
	}

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	case $ensure {
		activate: {
			exec { "wp plugin activate ${title} ${network}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin activate ${slug} ${held}",
				unless  => "/usr/bin/wp plugin is-active ${slug}",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		enabled: {
			exec { "wp install plugin ${title} --activate${network}${held}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin install ${slug} --activate ${held}",
				unless  => "/usr/bin/wp plugin is-installed ${slug}",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		disabled: {
			exec { "wp deactivate plugin ${title}${network}${held}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin deactivate ${slug}",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		installed: {
			exec { "wp install plugin ${title}${network}${held}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin install ${slug} ${held}",
				unless  => "/usr/bin/wp plugin is-installed ${slug}",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		deleted: {
			exec { "wp delete plugin ${title}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin delete ${slug}",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		uninstalled: {
			exec { "wp uninstall plugin ${title}":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin uninstall ${slug} --deactivate",
				require => Class['wp::cli'],
				onlyif  => '/usr/bin/wp core is-installed'
			}
		}
		default: {
			fail( 'Invalid ensure argument passed into wp::plugin' )
		}
	}
}
