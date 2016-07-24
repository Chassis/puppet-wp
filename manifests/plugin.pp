define wp::plugin (
	$slug = $title,
	$location,
	$ensure = enabled,
	$activate = true,
	$networkwide = false,
) {
	include wp::cli

	$network_activate_string = $networkwide ? {
		true  => '-network',
		false => '',
	}

	$network_string = $networkwide ? {
		true  => ' --network',
		false => '',
	}

	$activate_string = $activate ? {
		true  => join([' --activate', $network_string], ''),
		false => '',
	}

	case $ensure {
		present: {
			$command = "install $slug$activate_string"
			$unless  = ["/usr/bin/wp plugin is-installed $slug"]
		}
		activated: {
			$command = "activate $slug$network_string"
			$onlyif  = ["/usr/bin/wp plugin is-installed $slug"]
		}
		enabled: {
			$command = "activate $slug"

			exec { "wp install plugin $title":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp plugin install $slug",
				unless  => "/usr/bin/wp plugin is-installed $slug",
				before  => Wp::Command["$location plugin $slug $ensure"],
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
		}
		disabled: {
			$command = "deactivate $slug$network_string"
			$onlyif  = ["/usr/bin/wp plugin is-installed $slug"]
		}
		default: {
			fail("Invalid ensure for wp::plugin")
		}
	}

	wp::command { "$location plugin $slug $ensure":
		location => $location,
		command  => "plugin $command",
		onlyif   => $onlyif,
		unless   => $unless,
	}
}
