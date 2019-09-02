# A class for WP-CLI theme commands.
define wp::theme (
	$location,
	$slug = $title,
	$ensure = enabled,
	$onlyif = '/usr/bin/wp core is-installed',
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate ${slug}"
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
