define wp::theme (
	$slug     = $title,
	$location,
	$ensure   = enabled,
	$activate = false,
	$network  = false,
) {
	#$name = $title,
	include wp::cli

	$activated_param = $activate ? {
		true  => '--activate',
		false => ''
	}

	case $ensure {
		present: {
			$command = "install $slug$activated_param"
			$unless  = ["/usr/bin/wp theme is-installed $slug"]
		}
		activated: {
			$command = "activate $slug"
			$unless  = ["/usr/bin/wp theme status $slug | grep Active"]
			$onlyif  = ["/usr/bin/wp theme is-installed $slug"]
		}
		enabled: {
			if $network {
				$command = "enable $slug --network$activated_param"
				$onlyif  = ["/usr/bin/wp theme is-installed $slug"]
			} else {
				# For backward compatibility
				$command = "activate $slug"
				$onlyif  = ["/usr/bin/wp theme is-installed $slug"]
				$unless  = ["/usr/bin/wp theme status $slug | grep Active"]
			}
		}
		default: {
			fail("Invalid ensure for wp::theme")
		}
	}

	wp::command { "$location theme $command":
		location => $location,
		command  => "theme $command",
		onlyif   => $onlyif,
		unless   => $unless,
	}
}
