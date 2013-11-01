define wp::config (
	$location = $title,
	$dbname,
	$dbuser,
	$dbpass,
	$dbhost			= false,
	$dbprefix		= false,
	$dbcharset		= false,
	$dbcollate		= false,
	$locale			= false
) {
	include wp::cli

	$config = ''

	if ( $dbhost != false ) {
		$config += "--dbhost='$dbhost' "
	}

	if ( $dbprefix != false ) {
		$config += "--dbprefix='$dbprefix' "
	}

	if ( $dbcharset != false ) {
		$config += "--dbcharset='$dbcharset' "
	}

	if ( $dbcollate != false ) {
		$config += "--dbcollate='$dbcollate' "
	}

	if ( $locale != false ) {
		$config += "--locale='$locale' "
	}

	exec {"wp core config":
		command => "/usr/bin/wp core config --dbname='$dbname' --dbuser='$dbuser' --dbpass='$dbpass' $config",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		creates => "$location/wp-config.php"
	}
}
