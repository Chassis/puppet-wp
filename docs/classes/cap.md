# Cap

* [Description](/classes/cap.html#description)
* [Attributes](/classes/cap.html#attributes)

## Description

Adds or removes capabilities of a user role.

## Attributes
```puppet
    wp::cap { 'resource title':
      location    => # The location to run the command.
      ensure      => # What state the cap should be in.
      role        => # The role name.
      cap         => # The type of capablity.
      grant       => # A boolean value.
      onlyif      => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `present`.*)

The state the capability should be in.

Values: `present` or `absent`.

### role

The description for the role. e.g. `Approver`.

### cap

The name of the capability. e.g. `approver`.

### grant

(*If omitted, this attribute’s value defaults to `true`.*)

A boolean value of whether or not the role has the capability.

Values: `true` or `false`.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this.

