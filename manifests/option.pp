# A class for WordPress options.
define wp::option (
	$location,
	$key = $title,
	$value = undef,
	$ensure = present,
	$format = 'plaintext',
	$autoload = true,
) {
	case $ensure {
		present: {
			$command = "add ${key} --format=${format} --autoload=${autoload}"
		}
		equal: {
			if $value == undef {
				fail('Option value must be specified')
			}
			$command = "update ${key} ${value}"
		}
		absent: {
			$command = "delete ${key}"
		}
		default: {
			fail('Invalid option operation')
		}
	}

	wp::command { "${location} option ${command}":
		location => $location,
		command  => "option ${command}"
	}
}
