# A class for WP-CLI roles.
define wp::role (
  $location,
  $ensure = present,
  $id,
  $rolename,
  $all    = false,
  $user   = $::wp::user,
  $onlyif = '/usr/bin/wp core is-installed',
) {
  include wp::cli

  case $ensure {
    enabled: {
      $command = "create ${id} ${rolename}"
    }
    deleted: {
      $command = "delete ${id}"
    }
    reset: {
      if ( $all ) {
        $command = "reset --all"
      } else {
        $command = "reset ${id}"
      }
    }
    default: {
      fail( 'Invalid attributes for wp::role' )
    }
  }

  wp::command { "${location} role ${command}":
    location => $location,
    command  => $command,
    user     => $user,
    onlyif   => $onlyif,
  }
}
