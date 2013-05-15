define wp::option (
	$location,
	$name = $title,
	$value = undef,
	$ensure = present
) {
	include wp::cli

	case $ensure {
		present: {
			$command = "get $name"
		}
		equal: {
			if $value == undef {
				fail('Option value must be specified')
			}
			$command = "update $name $value"
		}
		absent: {
			$command = "delete $name"
		},
		default: {
			fail('Invalid option operation')
		}
	}

	exec {"wp option $command":
		command => "/usr/bin/wp option $command",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => '/usr/bin/test `/usr/bin/wp option get home`'
	}
}