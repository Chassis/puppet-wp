# Plugin

* [Description](/classes/plugin.html#description)
* [Attributes](/classes/plugin.html#attributes)

## Description

## Attributes
```puppet
    wp::plugin { 'resource title':
      location    => # 
      slug        => #
      ensure      => # 
      networkwide => #
      version     => # The location to run the command.
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
