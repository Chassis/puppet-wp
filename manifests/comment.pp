# A class for WP-CLI's commend commands.
class wp::comment (
  $location,
  $args,
  $ensure      = present,
  $metacommand = false,
  $user        = $::wp::user,
  $onlyif      = "${wp::params::bin_path}/wp core is-installed",
) {
  include wp::cli

  case $ensure {
    present: {
      $command = "create ${args}"
    }
    absent: {
      $command = "delete ${args}"
    }
    generate: {
      $command = "generate ${args}"
    }
    meta: {
      $command = "${metacommand} ${args}"
    }
    default: {
      fail( 'Invalid attribute for wp::comment' )
    }
  }
  wp::command { "${location} comment ${command}":
    location => $location,
    command  => "comment ${command}",
    user     => $user,
    onlyif   => $onlyif,
  }
}
