# Rewrite

* [Description](/classes/rewrite.html#description)
* [Attributes](/classes/rewrite.html#attributes)

## Description

Lists or flushes the site’s rewrite rules, updates the permalink structure.

## Attributes
```puppet
    wp::rewrite { 'resource title':
      location  => # The location to run the command.
      structure => # The rewrite structure.
      user      => # The user to run the command as.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### structure

(*If omitted, this attribute’s value defaults to the resource’s title.*)

Values: Any allowed WordPress permalink structure. e.g. `/%post_id%/%postname%/`, `/%year%/%monthnum%/%postname%/`, `/blog/%postname%/`.

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

The user to use to run the command.

### Examples

```puppet
  wp::rewrite { 'Year, Month, Name':
    location  => '/vagrant',
    structure => '/%year%/%monthnum%/%postname%/', 
  }
```

