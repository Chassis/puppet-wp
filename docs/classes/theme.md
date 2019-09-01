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
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `enabled`.*)

Value: `enabled`.

#### Examples
```puppet
  wp::theme { 'Activate Twenty Nineteen':
    location => '/vagrant',
    slug     => 'twentynineteen',
    ensure   => 'enabled'
  }
```
