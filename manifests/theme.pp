# A class for WP-CLI theme commands.
define wp::theme (
	$location,
	$slug        = $title,
	$ensure      = enabled,
	$networkwide = false,
	$version     = 'latest',
	$unless      = undef,
	$user        = $::wp::user,
	$onlyif      = "${wp::params::bin_path}/wp core is-installed",
	$all         = false,
	$mod         = false,
	$key         = false,
	$value       = false,
) {
	include wp::cli

	if ( $networkwide ) {
		$network = ' --network'
	}

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	if ( $all ) {
		$remove_all = ' --all'
	}

	case $ensure {
		activate: {
			$command = "activate ${slug}${held}"
		}
		enabled: {
			$command = "install ${slug}${held} --activate"
		}
		disabled: {
			$command = "disable ${slug}${network}"
		}
		installed: {
			$command = "install ${slug}${held}"
		}
		deleted: {
			if ( $all ) and ( $mod != false ) {
				$command = "delete ${slug}${held}$"
			} else {
				$command = "delete ${remove_all}"
			}
		}
		mod: {
			if ( $all ) and ( $mod != 'remove' ) {
				$command = "mod ${mod} ${key} ${value}"
			} else {
				$command = "mod ${mod} ${remove_all}"
			}
		}
		default: {
			fail('Invalid ensure for wp::theme')
		}
	}
	wp::command { "${location} theme ${command}":
		location => $location,
		command  => "theme ${command}",
		user     => $user,
		unless   => $unless,
		onlyif   => $onlyif,
	}
}
