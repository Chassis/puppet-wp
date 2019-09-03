# Plugin

* [Description](/classes/plugin.html#description)
* [Attributes](/classes/plugin.html#attributes)

## Description

Manages plugins, including installs, activations, and updates.

## Attributes
```puppet
    wp::plugin { 'resource title':
      location    => # The location to run the command.
      slug        => # The slug of the plugin in the WordPress repository.
      ensure      => # What state the option should be in.
      networkwide => # Whether the state should be applied network wide.
      version     => # The version of the plugin to install.
      unless      => # A test command that checks the state of the target system and restricts when the command can run.
      onlyif      => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### slug

(*If omitted, this attribute’s value defaults to the resource’s title.*)

### ensure

(*If omitted, this attribute’s value defaults to enabled.*)

Values: `activate`, `enabled`, `disabled`, `installed`, `deleted`, `uninstalled`.

### networkwide

(*If omitted, this attribute’s value defaults to false*)

Values: `true`, `false`

### version

(*If omitted, this attribute’s value defaults to the latest version in the WordPress repository*)

Values: `latest` or a version number e.g. `1.0.1`.

### unless

(*If omitted, this attribute’s value defaults to `undef` which Puppet treats as `false`.*)

A test command that checks the state of the target system and restricts when the command can run.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this. e.g.

```puppet
    wp::command { 'WP-CLI Info':
        location => '/vagrant'
        command  => '--info',
        onlyif   => [
          '/usr/bin/wp core is-installed',
          '/usr/bin/wp theme is-active twentynineteen',
        ]
    }
```

#### Examples
Install and activate Yoast SEO.
```puppet
  wp::plugin { 'Install and activate Yoast SEO':
    location => '/vagrant',
    slug     => 'wordpress-seo',
    ensure   => 'enabled',
  }
```

Install and activate Yoast SEO Network Wide.
```puppet
  wp::plugin { 'Install and activate Yoast SEO':
    location    => '/vagrant',
    slug        => 'wordpress-seo',
    ensure      => 'enabled',
    networkwide => 'true',
  }
```

Install Yoast SEO.
```puppet
  wp::plugin { 'Install Yoast SEO':
    location    => '/vagrant',
    slug        => 'wordpress-seo',
    ensure      => 'installed',
  }
```

Activate Yoast SEO.
```puppet
  wp::plugin { 'Activate Yoast SEO':
    location    => '/vagrant',
    slug        => 'wordpress-seo',
    ensure      => 'activate',
  }
```

Delete Hello Dolly.
```puppet
  wp::plugin { 'Delete Hello Dolly':
    location    => '/vagrant',
    slug        => 'hello-dolly',
    ensure      => 'deleted',
  }
```

Deactivate Hello Dolly.
```puppet
  wp::plugin { 'Deactivate Hello Dolly':
    location    => '/vagrant',
    slug        => 'hello-dolly',
    ensure      => 'disabled',
  }
```

Uninstall Hello Dolly.
```puppet
  wp::plugin { 'Uninstall Hello Dolly':
    location    => '/vagrant',
    slug        => 'hello-dolly',
    ensure      => 'uninstalled',
  }
```
