# A class for WP-CLI's user commands.
class wp::user (
  $location,
  $ensure = present,
  $args,
  $onlyif = '/usr/bin/wp core is-installed',
) {
  case $ensure {
    present: {
      $command = "create ${args}"
    }
    absent: {
      $command = "delete ${args}"
    }
    equal: {
      $command = "update ${args}"
    }
    generate: {
      $command = "generate ${args}"
    }
    add-role: {
      $command = "add-role ${args}"
    }
    set-role: {
      $command = "set-role ${args}"
    }
    remove-role: {
      $command = "remove-role ${args}"
    }
    add-cap: {
      $command = "add-cap ${args}"
    }
    remove-cap: {
      $command = "remove-cap ${args}"
    }
    meta: {
      $command = "meta ${args}"
    }
    term: {
      $command = "term ${args}"
    }
    import: {
      $command = "import-csv ${args}"
    }
    default: {
      fail( 'Invalid attribute for wp::user' )
    }
  }
  wp::command { "${location} user ${command}":
    location => $location,
    command  => "user ${command}",
    onlyif   => $onlyif,
  }
}
