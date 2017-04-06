define wp::theme (
	$slug = $title,
	$location,
	$ensure = enabled
) {
	include wp::cli

	case $ensure {
		enabled: {
			exec { "wp install theme $title --activate$network$held":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp theme install $slug --activate $held",
				unless  => "/usr/bin/wp theme is-installed $slug",
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
		}
		disabled: {
			exec { "wp disable theme $title$network$held":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp theme deactivate $slug",
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
		}
		installed: {
			exec { "wp install theme $title$network$held":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp theme install $slug --activate $held",
				unless  => "/usr/bin/wp theme is-installed $slug",
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
		}
		deleted: {
			exec { "wp delete theme $title":
				cwd     => $location,
				user    => $::wp::user,
				command => "/usr/bin/wp theme delete $slug",
				require => Class["wp::cli"],
				onlyif  => "/usr/bin/wp core is-installed"
			}
		}
		default: {
			fail( "Invalid ensure argument passed into wp::theme" )
		}
	}
}
