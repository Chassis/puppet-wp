define wp::command (
	$location,
	$command,
	$www_user
) {
	include wp::cli

	exec {"$location wp $command":
		command => "/usr/bin/wp $command",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		onlyif => "/usr/bin/sudo -u '$www_user' wp core is-installed"
	}
}