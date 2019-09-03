# User

* [Description](/classes/user.html#description)
* [Attributes](/classes/user.html#attributes)

## Description

Manages users, along with their roles, capabilities, and meta.

## Attributes
```puppet
    wp::user { 'resource title':
      location  => # The location to run the command.
      ensure    => # What state the cap should be in.
      args      => # The string of arguments to pass to the comment command.
      user      => # The user to run the command as.
      onlyif    => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `present`.*)

The state the capability should be in.

Values: `present`, `absent`, `equal`, `generate`, `add-role`, `set-role`, `remove-role`, `add-cap`, `remove-cap`, `meta`, `term` or `import`.

### args

A string of arguments to pass to the command. e.g.
* If `ensure => generate` and `args => '--count=200'` then this would generate 200 users.
* If `ensure => create` and `args => 'bob bob@example.com --role=author'` then this would generate a new user called `bob`.
* If `ensure => meta` and `args => 'add 123 bio "Mary is an WordPress developer."'` then a `bio` custom field would be added to user with the ID of `123`.

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

The user to use to run the command.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this.
