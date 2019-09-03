# A class for WP-CLI's cap commands.
define wp::cap (
  $location,
  $ensure = present,
  $role,
  $cap,
  $grant  = true,
  $user   = $::wp::user,
  $onlyif = '/usr/bin/wp core is-installed',
) {
  case $ensure {
    present: {
      $command = "add ${role} ${cap} --grant=${grant}"
    }
    absent: {
      $command = "remove ${role} ${cap}"
    }
    default: {
      fail( 'Invalid attribute for wp::cap' )
    }
  }
  wp::command { "${location} cap ${command}":
    location => $location,
    command  => "cap ${command}",
    user     => $user,
    onlyif   => $onlyif,
  }
}
