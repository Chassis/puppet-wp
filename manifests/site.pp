# Create a type for "wp site" commands
define wp::site (
	$aliases = [],
	$location = undef,
) {
	include wp::cli

	wp::create_subsite { $aliases:
		aliases  => $aliases,
		location => $location,
	}
}