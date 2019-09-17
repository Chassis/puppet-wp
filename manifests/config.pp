# A class for WP-CLI's config commands.
class wp::config (
	$location,
	$dbname,
	$dbuser,
	$dbpass,
	$ensure = present,
	$dbhost	   = 'localhost',
	$dbprefix  = 'wp_',
	$dbcharset = 'utf8',
	$dbcollate = '',
	$locale	   = 'en_AU',
	$value     = '',
	$user      = $::wp::user,
	$unless    = undef,
	$onlyif    = "${wp::params::bin_path}/wp is-installed",
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
