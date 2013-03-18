define wp::plugin (
	$name = $title,
	$location,
	$ensure = enabled,
	$networkwide = false
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate $name"
		}
		disabled: {
			$command = "deactivate $name"
		}
		default: {
			fail("Invalid ensure for wp::plugin")
		}
	}

	if $networkwide {
		$args = "plugin $command --network"
	}
	else {
		$args = "plugin $command"
	}

	exec {"wp $args":
		command => "/usr/bin/wp $args",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => '/usr/bin/test `/usr/bin/wp option get home`'
	}
}