# Theme

* [Description](/classes/theme.html#description)
* [Attributes](/classes/theme.html#attributes)

## Description

Manages themes, including installs, activations, and updates.

## Attributes
```puppet
    wp::theme { 'resource title':
      location  => # The location to run the command.
      slug      => # The slug of the theme.
      ensure    => # What state the option should be in.
      onlyif    => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### slug

The slug of the theme. e.g. `twentynineteen`.

### ensure

(*If omitted, this attribute’s value defaults to `enabled`.*)

Value: `enabled`.

### version

(*If omitted, this attribute’s value defaults to the latest version in the WordPress repository*)

Values: `latest` or a version number e.g. `1.3`.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this. e.g.

```puppet
  wp::theme { 'Activate Twenty Nineteen':
    location => '/vagrant',
    slug     => 'twentynineteen',
    ensure   => 'enabled'
    onlyif   => [
      '/usr/bin/wp core is-installed',
      '/usr/bin/wp theme is-active twentynineteen',
     ]
    }
```

#### Examples
```puppet
  wp::theme { 'Activate Twenty Nineteen':
    location => '/vagrant',
    slug     => 'twentynineteen',
    version  => '1.3',
    ensure   => 'enabled',
  }
```
