define wp::config (
  $location = $title,
  $dbname    = 'wordpress',
  $dbuser    = 'wordpress',
  $dbpass    = 'P@ssw0rd',
  $dbhost    = 'localhost',
  $dbprefix  = 'wp_',
  $dbcharset = 'utf8',
) {
  include wp::cli

  $config = "config --path='$location' --dbname='$dbname' --dbuser='$dbuser' --dbpass='$dbpass' --dbhost='$dbhost' --dbprefix='$dbprefix'"
  
  exec {"wp config $location":
    command => "/usr/bin/wp core $config",
    user    => $::wp::user,
    require => [ Class['wp::cli'] ],
    path    => "/bin:/usr/bin:/usr/sbin",
    creates => "${location}/wp-config.php", 
  }
}
