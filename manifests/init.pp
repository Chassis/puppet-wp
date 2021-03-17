# Our base Puppet WP Class.
class wp (
	$user = $::wp::params::user,
	$php_package = $::wp::params::php_package,
	$php_executable_path = $::wp::params::php_executable_path,
	$bin_path = $::wp::params::bin_path,
	$executable_filename = $::wp::params::executable_filename,
	$manage_php_package = $::wp::params::manage_php_package,
	$manage_curl_package = $::wp::params::manage_curl_package,
	$manage_git_package = $::wp::params::manage_git_package,
) inherits wp::params {
	# ...
}
