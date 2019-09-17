# A class for WP-CLI roles.
define wp::role (
  $location,
  $id,
  $rolename,
  $ensure = present,
  $all    = false,
  $user   = $::wp::user,
  $onlyif = "${wp::params::bin_path}/wp core is-installed",
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
        $command = 'reset --all'
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
