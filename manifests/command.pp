define wp::command (
	$location,
	$command,
	$onlyif  = [],
	$unless  = [],
) {
	include wp::cli

	exec {"$location wp $command":
		command => "/usr/bin/wp $command",
		cwd => $location,
		user => $::wp::user,
		require => [ Class['wp::cli'] ],
		onlyif => concat( ['/usr/bin/wp core is-installed'], $onlyif ),
		unless => $unless,
	}
}
