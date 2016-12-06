define wp::site (
	$location = $title,
	$url,
	$siteurl = $url,
	$sitename       = 'WordPress Site',
	$admin_user     = 'admin',
	$admin_email    = 'admin@example.com',
	$admin_password = 'password',
	$network        = false,
	$subdomains     = false
) {
	include wp::cli

	if ( $network == true ) and ( $subdomains == true ) {
		$install = "multisite-install --subdomains --url='$url'"
		$convert = "multisite-convert --subdomains --url='$url'"
	}
	elsif ( $network == true ) {
		$install = "multisite-install --url='$url'"
		$convert = "multisite-convert --url='$url'"
	}
	else {
		$install = "install --url='$url'"
	}

	if ( $network ) {
		exec {"wp multisite-convert $location":
			command => "/usr/bin/wp core $convert",
			cwd => $location,
			logoutput => true,
			user => $::wp::user,
			require => [ Class['wp::cli'] ],
			before => [ Exec[ "wp install $location" ] ],
			onlyif => '/usr/bin/wp core is-installed',
			unless => '/usr/bin/wp core is-installed --network',
		}
	}

	exec {"wp install $location":
		command => "/usr/bin/wp core $install --title='$sitename' --admin_email='$admin_email' --admin_name='$admin_user' --admin_password='$admin_password'",
		cwd => $location,
		user => $::wp::user,
		require => [ Class['wp::cli'] ],
		unless => '/usr/bin/wp core is-installed'
	}

	if $siteurl != $url {
		wp::option {"wp siteurl $location":
			location => $location,
			ensure => "equal",
			user => $::wp::user,

			key => "siteurl",
			value => $siteurl
		}
	}
}
