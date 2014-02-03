define wp::plugin (
	$slug = $title,
	$location,
	$ensure = enabled,
	$networkwide = false,
	$www_user
) {
	include wp::cli

	case $ensure {
		enabled: {
			$command = "activate $slug"

			exec { "sudo -u '$www_user' wp install plugin $title":
				cwd     => $location,
				command => "/usr/bin/wp plugin install $slug",
				unless  => "/usr/bin/wp plugin is-installed $slug",
				before  => Wp::Command["$location plugin $slug $ensure"],
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/sudo -u '$www_user' wp core is-installed"
			}
		}
		disabled: {
			$command = "deactivate $slug"
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
	wp::command { "$location plugin $slug $ensure":
		location => $location,
		command => $args
	}
}
