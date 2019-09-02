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
      all       => # If set this will delete all the themes apart from the theme that has been passed into the class.
      mod       => # The action of the theme mod.
      key       => # The key of the theme mod.
      value     => # The value of the theme mod.
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

### all

(*If omitted, this attribute’s value defaults to `false`.*)

If set this and `ensure => 'deleted'` then it will delete all the themes apart from the active theme.
If set this and `mod => 'remove'` then it will delete all theme mods.

Value: `true`.

```puppet
  wp::theme { 'Activate Twenty Nineteen and delete all other themes':
    location => '/vagrant',
    slug     => 'twentynineteen',
    ensure   => 'deleted',
    all      => true,
  }
```

### mod

(*If omitted, this attribute’s value defaults to `false`.*)

Values: `get`, `set` or `remove`.

```puppet
  wp::theme { 'Activate Twenty Nineteen and delete all other themes':
    location => '/vagrant',
    ensure   => 'mod',
    mod      => 'set',
    key      => 'background_color',
    value    => '000000',
  }
```

### key

(*If omitted, this attribute’s value defaults to `false`.*)

This is the key used with [mod](/classes/theme.html#mod).

### value

(*If omitted, this attribute’s value defaults to `false`.*)

This is the value used with [mod](/classes/theme.html#mod).

#### Examples
```puppet
  wp::theme { 'Activate Twenty Nineteen':
    location => '/vagrant',
    slug     => 'twentynineteen',
    version  => '1.3',
    ensure   => 'enabled',
  }
```
