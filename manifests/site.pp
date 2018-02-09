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

	if ( $network == true ) and ( $subdomains == true ) {
		$install = "multisite-install --subdomains --url='$url'"
	}
	elsif ( $network == true ) {
		$install = "multisite-install --url='$url'"
	}
	else {
		$install     = "install --url='$url'"
		$new_install = true
	}

	if ( $new_install == true ) {
		exec { "wp install $location":
			command => "/usr/bin/wp core $install --title='$sitename
				' --admin_email='$admin_email' --admin_name='$admin_user
				' --admin_password='$admin_password'",
			cwd     => $location,
			user    => $user,
			require => [ Class['wp::cli'] ],
			unless  => '/usr/bin/wp core is-installed'
		}
	} else {
		exec { "wp install $location":
			command => "/usr/bin/wp core $install --title='$sitename
				' --admin_email='$admin_email' --admin_name='$admin_user
				' --admin_password='$admin_password'",
			cwd     => $location,
			user    => $user,
			require => [ Class['wp::cli'] ],
		}
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
