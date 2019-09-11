# Create a type for "wp site" commands
define wp::site (
	$aliases,
	$location,
) {
	include wp::cli

	create_subsite { $aliases:
		aliases  => $aliases,
		location => $location,
	}
}

# Create a type for "wp site create"
define create_subsite (
	$aliases,
	$location,
) {
	# Generate the slugs for the subsites.
	if ( $name != $aliases[0] ) {
		$slug = regsubst( $name, ".${aliases[0]}", '')
	}

	if ( $slug ) {
		exec { "wp site create --slug=${slug}":
			cwd       => $location,
			user      => $::wp::user,
			command   => "/usr/bin/wp site create --slug=${slug}",
			unless    => "/usr/bin/wp site list | grep $slug",
			require   => Class['wp::cli'],
			onlyif    => "/usr/bin/wp core is-installed",
			logoutput => true
		}
     }
}
