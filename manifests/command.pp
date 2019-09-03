# A class for WP-CLI commands.
define wp::command (
	$location,
	$command,
	$user = $::wp::user,
	$unless = undef,
	$onlyif = '/usr/bin/wp core is-installed',
) {
	include wp::cli

	exec {"${location} wp ${command}":
		command => "/usr/bin/wp ${command}",
		cwd     => $location,
		user    => $user,
		require => [ Class['wp::cli'] ],
		unless  => $unless,
		onlyif  => $onlyif,
	}
}
