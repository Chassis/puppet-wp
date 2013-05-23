define wp::option (
	$location,
	$name = $title,
	$value = undef,
	$ensure = present
) {
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

	wp::command { "$location option $command":
		location => $location,
		command => "option $command"
	}
}