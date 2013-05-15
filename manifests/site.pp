define wp::site (
	$location = $title,
	$url,
	$sitename       = 'WordPress Site',
	$admin_user     = 'admin',
	$admin_email    = 'admin@example.com',
	$admin_password = 'password'
) {
	include wp::cli

	exec {"wp install $location":
		command => "/usr/bin/wp core install --url='$url' --title='$sitename' --admin_email='$admin_email' --admin_password='$admin_password'",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		unless => '/usr/bin/test `/usr/bin/wp option get home`'
	}
}