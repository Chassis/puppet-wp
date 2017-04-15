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
	$user           = $::wp::user,
) {
	include wp::cli
	include wp::params

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
		command => "${wp::params::bin_path}/wp core $install --title='$sitename' --admin_email='$admin_email' --admin_name='$admin_user' --admin_password='$admin_password'",
		cwd => $location,
		user => $user,
		require => [ Class['wp::cli'] ],
		unless => "${wp::params::bin_path}/wp core is-installed"
	}

	if $siteurl != $url {
		wp::option {"wp siteurl $location":
			location => $location,
			ensure => "equal",
			user => $user,

			key => "siteurl",
			value => $siteurl
		}
	}
}
