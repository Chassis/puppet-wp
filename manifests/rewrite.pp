define wp::rewrite (
	$location,
	$structure = $title
) {
	include wp::cli

	exec {"wp rewrite structure '$structure'":
		command => "/usr/bin/wp rewrite structure '$structure'",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => '/usr/bin/test `/usr/bin/wp option get home`'
	}
}