define wp::download (
	$location = $title,
	$locale         = false,
	$version        = false,
	$force          = false
) {
	include wp::cli

	$download = ''

	if ( $locale != false ) {
		$download += "--locale='$locale' "
	}

	if ( $version != false ) {
		$download += "--version='$version' "
	}

	if ( $force != false ) {
		$download += "--force"
	}

	exec {"wp core download":
		command => "/usr/bin/wp core download $download",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		creates => [ "$location/wp-admin", "$location/wp-content", "$location/wp-includes" ]
	}
}
