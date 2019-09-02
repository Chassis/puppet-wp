# A class for WP-CLI theme commands.
define wp::theme (
	$location,
	$slug = $title,
	$ensure = enabled,
	$networkwide = false,
	$version = 'latest',
	$onlyif = '/usr/bin/wp core is-installed',
	$all = false,
	$mod = false,
	$key = false,
	$value = false,
) {
	include wp::cli

	if ( $networkwide ) {
		$network = ' --network'
	}

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	if ( $all ) {
		$all_themes = ' --all'
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
			$command = "delete ${slug}${held}${all}"
		}
		mod: {
			$command = "mod ${mod} ${key} ${value}"
		}
		default: {
			fail('Invalid ensure for wp::theme')
		}
	}
	wp::command { "${location} theme ${command}":
		location => $location,
		command  => "theme ${command}",
		onlyif   => $onlyif,
	}
}
