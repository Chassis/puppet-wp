# A class for WP-CLI's commend commands.
class wp::comment (
  $location,
  $ensure      = 'present',
  $metacommand = false,
  $onlyif      = '/usr/bin/wp core is-installed',
  $args,
) {
  case $ensure {
    'present': {
      $command = "create ${args}"
    }
    'absent': {
      $command = "delete ${args}"
    }
    'generate': {
      $command = "generate ${args}"
    }
    'meta': {
      $command = "${metacommand} ${args}"
    }
    default: {
      fail( 'Invalid attribute for wp::comment' )
    }
  }
  wp::command { "${location} comment ${command}":
    location => $location,
    command  => "comment ${command}",
    onlyif   => $onlyif,
  }
}
