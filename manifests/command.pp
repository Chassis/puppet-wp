# A class for WP-CLI commands.
define wp::command (
	$location,
	$command,
	$user = $::wp::user,
	$unless = undef,
	$onlyif = "${wp::bin_path}/${wp::executable_filename} core is-installed",
) {
	include wp::cli

	exec {"${location} wp ${command}":
		command => "${wp::bin_path}/${wp::executable_filename} ${command}",
		cwd     => $location,
		user    => $user,
		require => [ Class['wp::cli'] ],
		unless  => $unless,
		onlyif  => $onlyif,
	}
}
