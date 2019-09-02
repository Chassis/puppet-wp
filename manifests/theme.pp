# A class for WP-CLI theme commands.
define wp::theme (
	$location,
	$slug = $title,
	$ensure = enabled,
	$version = 'latest',
	$onlyif = '/usr/bin/wp core is-installed',
) {
	include wp::cli

	if ( $version != 'latest' ) {
		$held = " --version=${version}"
	}

	case $ensure {
		activate: {
			$command = "activate ${slug} ${held}"
		}
		enabled: {
			$command = "install ${slug} ${held} --activate"
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
