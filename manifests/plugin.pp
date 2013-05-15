define wp::plugin (
	$location,
	$ensure = enabled,
	$networkwide = false
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate $title"
		}
		disabled: {
			$command = "deactivate $title"
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