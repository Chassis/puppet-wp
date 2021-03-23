# A class for WordPress option patch subcommand.
define wp::option::patch (
	$location,
	$key       = $title,
	$key_path  = undef,
	$value     = undef,
	$ensure    = present,
	$format    = 'plaintext',
	$user      = $::wp::user,
) {
	include wp::cli

	case $ensure {
		present: {
			$command = "insert ${key} ${key_path} ${value} --format=${format}"
		}
		equal: {
			if $value == undef {
				fail('Option value must be specified')
			}
			$command = "update ${key} ${key_path} ${value}"
		}
		absent: {
			$command = "delete ${key} ${key_path}"
		}
		default: {
			fail('Invalid option operation')
		}
	}

	wp::command { "${location} option patch ${command}":
		location => $location,
		command  => "option patch ${command}",
		user     => $user,
	}
}
