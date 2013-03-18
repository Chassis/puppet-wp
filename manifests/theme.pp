define wp::theme (
	$name = $title,
	$location,
	$ensure = enabled
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate $name"
		}
		default: {
			fail("Invalid ensure for wp::theme")
		}
	}

	exec {"wp theme $command":
		command => "/usr/bin/wp theme $command",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => '/usr/bin/test `/usr/bin/wp option get home`'
	}
}