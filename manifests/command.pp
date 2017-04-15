define wp::command (
	$location,
	$command
) {
	include wp::cli
  include wp::params

	exec {"$location wp $command":
		command => "${wp::params::bin_path}/wp $command",
		cwd => $location,
		user => $::wp::user,
		require => [ Class['wp::cli'] ],
		onlyif => "${wp::params::bin_path}/wp core is-installed"
	}
}
