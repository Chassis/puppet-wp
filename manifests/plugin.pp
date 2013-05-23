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
	wp::command { "$location $args":
		location => $location,
		command => $args
	}
}