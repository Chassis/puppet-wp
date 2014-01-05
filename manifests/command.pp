define wp::command (
	$location,
	$command
) {
	include wp::cli

	exec {"$location wp $command":
		command => "/usr/bin/wp $command",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => '/usr/bin/wp core is-installed'
	}
}