# Command

* [Description](/classes/command.html#description)
* [Attributes](/classes/command.html#attributes)

## Description

Executes WP-CLI commands.

## Attributes
``` puppet
	wp::command { 'resource title':
		location => # The location to run the command
		command  => # The WP-CLI command to run
		user     => # The user to run the command as.
		unless   => # A test command that checks the state of the target system and restricts when the command can run
		onlyif   => # A test command that checks the state of the target system and restricts when the exec can run.
	}
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### command

The actual command to execute. For example of you wanted to run `wp --info` you would to the following:
```puppet
    wp::command { 'WP-CLI Info':
        location => '/vagrant',
        command  => '--info',
    }
```

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

### unless

(*If omitted, this attribute’s value defaults to `undef` which Puppet treats as `false`.*)

A test command that checks the state of the target system and restricts when the exec can run.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/local/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this. e.g.

```puppet
    wp::command { 'WP-CLI Info':
        location => '/vagrant'
        command  => '--info',
        onlyif   => [
          '/usr/local/bin/wp core is-installed',
          '/usr/local/bin/wp theme is-active twentynineteen',
        ]
    }
```
