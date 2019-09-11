# Config

* [Description](/classes/config.html#description)
* [Attributes](/classes/config.html#attributes)

## Description

Generates and edits the wp-config.php file.

## Attributes
```puppet
    wp::config { 'resource title':
        location  => # The location to run the command.
        ensure    => # What state the option should be in.
        dbname    => # The database name.
        dbuser    => # The database user.
        dbpass    => # The database password.
        dbhost    => # The database host name.
        dbprefix  => # The database prefix.
        dbcharset => # The database character set.
        dbcollate => # The database collation.
        locale    => # The langage that you want WordPress to use.
        value     => # The value to send to the command.
        unless    => # A test command that checks the state of the target system and restricts when the command can run.
        user      => # The user to run the command as.
        onlyif    => # A test command that checks the state of the target system and restricts when the command can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `present`.*)

Values: `present`, `absent` or `equal`.

### dbname

Set the database name.

### dbuser

Set the database user password.

### dbpass

Set the database host.

### dbhost

(*If omitted, this attribute’s value defaults to `localhost`.*)

### dbprefix

(*If omitted, this attribute’s value defaults to `wp_`.*)

Set the database table prefix.

### dbcharset

(*If omitted, this attribute’s value defaults to `utf8`.*)

Set the database charset.

### dbcollate

(*If omitted, this attribute’s value defaults to `''`.*)

Set the database collation.

### locale

(*If omitted, this attribute’s value defaults to `en_AU`.*)

Set this to the language you'd like WordPress to use. e.g. `en_US`.

### value

(*If omitted, this attribute’s value defaults to `''`.*)

### unless

(*If omitted, this attribute’s value defaults to `undef` which Puppet treats as `false`.*)

A test command that checks the state of the target system and restricts when the command can run.

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

### Example

```puppet
    wp::config { 'Create config':
        location => '/vagrant'
        dbname   => 'wordpress'
        dbuser   => 'wordpress'
        dbpass   => 'vagrantpassword'
    }
```


