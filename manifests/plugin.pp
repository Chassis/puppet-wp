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
	$user        = $::wp::user,
	$onlyif      = "${wp::params::bin_path}/wp core is-installed",
) {
	include wp::cli

	if ( $networkwide ) {
		$network = ' --network'
	}

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	if ( empty( $all ) ) {
		$delete_all_plugins = ' --all'
	}

	if ( empty( $skipdelete ) ) {
		$skip_deleting_plugins = ' --skip-delete'
	}

	case $ensure {
		activate: {
			$command = "activate ${slug} ${held}"
			$unless_check = "is-active ${slug}"
		}
		enabled: {
			$command = "plugin install ${slug} --activate ${held}"
			$unless_check = "plugin is-installed ${slug}"
		}
		disabled: {
			$command = "plugin deactivate ${slug}"
		}
		installed: {
			$command = "plugin install ${slug} ${held}"
			$unless_check = "plugin is-installed ${slug}"
		}
		deleted: {
			$command = "plugin delete ${slug}${delete_all_plugins}"
		}
		uninstalled: {
			$command = "plugin uninstall ${slug} --deactivate${skip_deleting_plugins}"
		}
		default: {
			fail('Invalid ensure argument passed into wp::plugin')
		}
	}
	wp::command { "${location} plugin ${command}":
		location => $location,
		command  => "plugin ${command}",
		unless   => $unless_check,
		user     => $user,
		onlyif   => $onlyif,
	}
}
