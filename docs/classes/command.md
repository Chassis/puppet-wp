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
	}
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### command

The actual command to execute. For example of you wanted to run `wp --info` you would to the following:
```puppet
    wp::command { 'WP-CLI Info':
        location => '/vagrant'
        command  => '--info'
    }
```
