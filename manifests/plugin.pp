# A class for WP-CLI's plugin commands.
define wp::plugin (
	$location,
	$slug        = $title,
	$ensure      = enabled,
	$networkwide = false,
	$version     = 'latest',
	$all         = '',
	$skipdelete  = '',
	$unless      = undef,
	$onlyif      = '/usr/bin/wp core is-installed',
) {
	include wp::cli

	if ( $networkwide ) {
		$network = ' --network'
	}

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	if ( empty( $all ) ) {
		$all = ' --all'
	}

	if ( empty( $skipdelete ) ) {
		$skipdelete = ' --skip-delete'
	}

	case $ensure {
		activate: {
			$command = "activate ${slug} ${held}"
			$unless = "is-active ${slug}"
		}
		enabled: {
			$command = "plugin install ${slug} --activate ${held}"
			$unless = "plugin is-installed ${slug}"
		}
		disabled: {
			$command = "plugin deactivate ${slug}"
		}
		installed: {
			$command = "plugin install ${slug} ${held}"
			$unless = "plugin is-installed ${slug}"
		}
		deleted: {
			$command = "plugin delete ${slug}${all}"
		}
		uninstalled: {
			$command = "plugin uninstall ${slug} --deactivate${skipdelete}"
		}
		default: {
			fail('Invalid ensure argument passed into wp::plugin')
		}
	}
	wp::command { "${location} plugin ${command}":
		location => $location,
		command  => "plugin ${command}",
		unless   => $unless,
		onlyif   => $onlyif,
	}
}
