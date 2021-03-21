# A class for parameters we might need to use.
class wp::params {
	$user = $::operatingsystem ? {
		'windows' => undef,
		default   => 'www-data',
	}
	$bin_path = '/usr/local/bin'
	$executable_filename = $::operatingsystem ? {
		'windows' => 'wp.bat',
		default   => 'wp',
	}
	$php_package = $::operatingsystem ? {
		/^(Debian|Ubuntu)$/ => 'php5-cli',
		'windows'           => 'php',
		default             => 'php-cli',
	}
	$php_executable_path = $::operatingsystem ? {
		'windows' => 'C:/tools/php80/php.exe',
		default   => '/usr/bin/php',
	}
	$manage_php_package = true
	$manage_curl_package = true
	$manage_git_package = true
}
