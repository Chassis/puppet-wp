# Our base Puppet WP Class.
class wp (
	$user = $::wp::params::user,
	$php_package = $::wp::params::php_package,
	$php_executable_path = $::wp::params::php_executable_path,
	$bin_path = $::wp::params::bin_path,
	$executable_filename = $::wp::params::executable_filename,
) inherits wp::params {
	# ...
}
