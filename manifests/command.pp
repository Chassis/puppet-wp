# A class for WP-CLI commands.
define wp::command (
	$location,
	$command,
	$onlyif = '/usr/bin/wp core is-installed',
) {
	include wp::cli

	exec {"${location} wp ${command}":
		command => "/usr/bin/wp ${command}",
		cwd     => $location,
		user    => $::wp::user,
		require => [ Class['wp::cli'] ],
		onlyif  => $onlyif,
	}
}
