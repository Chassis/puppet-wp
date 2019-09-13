# Role

* [Description](/classes/role.html#description)
* [Attributes](/classes/role.html#attributes)

## Description

Manages user roles, including creating new roles and resetting to defaults.

## Attributes
```puppet
    wp::role { 'resource title':
      location  => # The location to run the command.
      ensure    => # What state the option should be in.
      id        => # The role ID.
      rolename  => # The role name.
      all       => # If set this will delete all the themes apart from the theme that has been passed into the class.
      user      => # The user to run the command as.
      onlyif    => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `present`.*)

The action to run for the role.

Values: `enabled`, `deleted` or `reset`.

### id

The ID of the role. e.g. `approver`.

### rolename

The description for the role. e.g. `Approver`

### all

(*If omitted, this attribute’s value defaults to `false`.*)

If this is set to `true` and `ensure => reset` then all roles will be reset.

Values: `true` or `false`.

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

The user to use to run the command.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/local/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this. 
