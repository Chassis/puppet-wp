define wp::site (
	$location = $title,
	$url,
	$siteurl = $url,
	$sitename       = 'WordPress Site',
	$admin_user     = 'admin',
	$admin_email    = 'admin@example.com',
	$admin_password = 'password',
	$network        = false,
	$subdomains     = false,
    $www_user       = 'www-data'
) {
	include wp::cli

	if ( $network == true ) and ( $subdomains == true ) {
		$install = "multisite-install --subdomains --url='$url'"
	}
	elsif ( $network == true ) {
		$install = "multisite-install --url='$url'"
	}
	else {
		$install = "install --url='$url'"
	}

	exec {"wp install $location":
		command => "/usr/bin/sudo -u '$www_user' wp core $install --title='$sitename' --admin_email='$admin_email' --admin_name='$admin_user' --admin_password='$admin_password'",
		cwd => $location,
		require => [ Class['wp::cli'] ],
		unless => "/usr/bin/sudo -u '$www_user' wp core is-installed"
	}

	if $siteurl != $url {
		wp::option {"wp siteurl $location":
			location => $location,
			ensure => "equal",

			key => "siteurl",
			value => $siteurl
		}
	}
}
