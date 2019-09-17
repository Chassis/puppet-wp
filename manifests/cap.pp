# A class for WP-CLI's cap commands.
define wp::cap (
  $role,
  $cap,
  $location,
  $ensure = present,
  $grant  = true,
  $user   = $::wp::user,
  $onlyif = "${wp::params::bin_path}/wp core is-installed",
) {
  include wp::cli

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
