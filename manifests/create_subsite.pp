# Create a type for "wp site create"
define wp::create_subsite (
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
			command   => "${wp::params::bin_path}/wp site create --slug=${slug}",
			unless    => "${wp::params::bin_path}/wp site list | grep ${slug}",
			require   => Class['wp::cli'],
			onlyif    => "${wp::params::bin_path}/wp core is-installed",
			logoutput => true
		}
	}
}
