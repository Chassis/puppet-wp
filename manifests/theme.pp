define wp::theme (
  $location,
  $ensure = enabled,
  $manage_install = false,
  $install_name = '/tmp/theme.zip', # theme|zip|url 
  $theme_name = 'theme',
) {
  #$name = $title,
  include wp::cli

  if ($manage_install) {
    exec {"${location} wp theme install ${theme_name}":
      command => "/usr/bin/wp theme install ${install_name}",
      cwd     => $location,
      user    => $::wp::user,
      require => [ Class['wp::cli'] ],
      unless  => "/usr/bin/wp theme is-installed ${theme_name}"
    }
  }

  case $ensure {
    enabled: {
      $command = "activate $theme_name"
    }
    default: {
      fail("Invalid ensure for wp::theme")
    }
  }
  wp::command { "$location theme $command":
    location => $location,
    command => "theme $command"
  }
}