# A class for WP-CLI commands.
define wp::command (
	$location,
	$command,
	$user = $::wp::user,
	$unless = undef,
	$onlyif = "${wp::params::bin_path}/wp is-installed",
) {
	include wp::cli

	exec {"${location} wp ${command}":
		command => "${wp::params::bin_path}/wp ${command}",
		cwd     => $location,
		user    => $user,
		require => [ Class['wp::cli'] ],
		unless  => $unless,
		onlyif  => $onlyif,
	}
}
