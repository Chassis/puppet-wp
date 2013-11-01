# Puppet WP-CLI
This module enables the easy use of WP CLI to control your WordPress site
through Puppet manifests. It provides an easy abstraction for common WP CLI
commands as well as installing the WP CLI binaries as needed.

## Usage

	# Setup the site
	wp::download { '/vagrant/wp': }
	wp::config { '/vagrant/wp':
		dbname => $db_name,
		dbuser => $db_user,
		dbpass => $db_pass,
		require => Wp::Download['/vagrant/wp']
	}
	wp::site {'/vagrant/wp':
		# location => '/vagrant/wp',
		url => 'http://wordpress.local',
		name => 'Test Site',
		require => [ Mysql::Db['store'], Wp::Config['/vagrant/wp'] ]
	}
		wp::rewrite {'/%post_id%/%postname%/':
			# structure => '/%post_id%/%postname%/',
			location => $wplocation,
			require => Wp::Site['store']
		}

		# Set the options to their required values
		wp::option {'timezone_string':
			# key => 'timezone_string',
			value => 'Australia/Brisbane',
			location => $wplocation,
			require => Wp::Site['store']
		}
		wp::option {'update_core':
			# key => 'update_core',
			ensure => absent,
			location => $wplocation,
			require => Wp::Site['store']
		}

		# Setup themes and plugins
		wp::theme {'twentythirteen':
			location => '/vagrant/wp',
			require => Wp::Site['store'],
		}
		wp::plugin {'woocommerce':
			# ensure => enabled,
			location => '/vagrant/wp',
			require => Wp::Site['store'],
		}
		wp::plugin {'debug-bar':
			ensure => disabled,
			location => '/vagrant/wp',
			require => Wp::Site['store'],
		}

## License
This code is licensed under the MIT license.

Copyright (c) 2012-2013 Ryan McCue

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
