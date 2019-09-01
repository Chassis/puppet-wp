# A class for parameters we might need to use.
class wp::params {
	$user = 'www-data'

	$php_package = $::operatingsystem ? {
		/^(Debian|Ubuntu)$/ => 'php5-cli',
		default             => 'php-cli',
	}
}
