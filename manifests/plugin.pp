define wp::plugin (
	$location,
	$ensure = enabled,
	$networkwide = false
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate $title"

			exec { "wp install plugin $title":
				cwd     => $location,
				command => "/usr/bin/wp plugin install $title",
				unless  => "/usr/bin/wp plugin is-installed $title",
				before  => Wp::Command["$location plugin $title $ensure"],
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
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
	wp::command { "$location plugin $title $ensure":
		location => $location,
		command => $args
	}
}
