class wp::params {
	$user = 'www-data'
  $bin_path = '/usr/local/bin'

	$php_package = $::operatingsystem ? {
		/^(Debian|Ubuntu)$/ => 'php5-cli',
		default             => 'php-cli',
	}
}
