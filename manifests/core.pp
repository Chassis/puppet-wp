# A class for WP-CLI core commands.
define wp::core (
	$url,
	$location       = $title,
	$siteurl        = $url,
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
		$install = "multisite-install --subdomains --url='${url}'"
	}
	elsif ( $network == true ) {
		$install = "multisite-install --url='${url}'"
	}
	else {
		$install = "install --url='${url}'"
	}

	$command = "${install} --title='${sitename}' --admin_email='${admin_email}' --admin_user='${admin_user}' --admin_password='${admin_password}'"

	wp::command { "${location} core ${command}":
		location => $location,
		command  => "core ${command}",
		unless   => "${wp::params::bin_path}/wp core is-installed",
		user     => $user,
		onlyif   => [],
	}

	if $siteurl != $url {
		wp::option {"wp siteurl ${location}":
			ensure   => 'equal',
			location => $location,
			user     => $user,
			key      => 'siteurl',
			value    => $siteurl
		}
	}
}
