# A class for WP-CLI's config commands.
class wp::config (
	$location,
	$ensure = present,
	$dbname,
	$dbuser,
	$dbpass,
	$dbhost	   = 'localhost',
	$dbprefix  = 'wp_',
	$dbcharset = 'utf8',
	$dbcollate = '',
	$locale	   = 'en_AU',
	$value     = '',
	$user      = $::wp::user,
	$unless    = undef,
	$onlyif    = '/usr/bin/wp core is-installed',
) {
	case $ensure {
		present: {
			$command = "create --dbname=${dbname} --dbuser${dbuser} --dbpass=${dbpass} --dbhost=${dbhost} --dbprefix=${dbprefix} --force"
		}
		absent: {
			$command = "delete ${value}"
		}
		equal: {
			$command = "set ${value}"
		}
		default: {
			fail( 'Invalid attribute for wp::config' )
		}
	}
	wp::command { "${location} config ${command}":
		location => $location,
		command  => "config ${command}",
		user     => $user,
		unless   => $unless,
		onlyif   => $onlyif,
	}
}
