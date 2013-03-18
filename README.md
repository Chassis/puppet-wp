# Puppet WP-CLI

## Usage

	wp::site {'store':
		location => '/vagrant/wp',
		url => 'http://wordpress.local',
		name => 'Test Site',
		require => Mysql::Db['store']
	}
		wp::theme {'twentythirteen':
			location => '/vagrant/wp',
			require => Wp::Site['store'],
		}
		wp::plugin {'woocommerce':
			location => '/vagrant/wp',
			require => Wp::Site['store'],
		}