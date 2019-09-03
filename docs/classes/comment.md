# Comment

* [Description](/classes/comment.html#description)
* [Attributes](/classes/comment.html#attributes)

## Description

Creates, updates and deletes comments.

## Attributes
```puppet
    wp::comment { 'resource title':
      location    => # The location to run the command.
      ensure      => # What state the cap should be in.
      metacommand => # Is the comment's meta being altered.
      args        => # The string of arguments to pass to the comment command. 
      onlyif      => # A test command that checks the state of the target system and restricts when the exec can run.
    }
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### ensure

(*If omitted, this attribute’s value defaults to `present`.*)

The state the comment should be in.

Values: `present`, `absent`, `generate` or `meta`.

### metacommand

(*If omitted, this attribute’s value defaults to `false`.*)

The type of meta command to run.

Values: `add`, `delete`, `patch` or `update`.

### args

A string of arguments to pass to the command. e.g.
* If `ensure => generate` then `args => '--count=100'` would generate 100 comments.
* If `ensure => present` then `args => '--comment_post_ID=15 --comment_content="hello blog" --comment_author="wp-cli"'` would add one comment.
* IF `ensure => absent` then `args => '1337 2341 --force'` would delete two comments and not trash them.

### onlyif

(*If omitted, this attribute’s value defaults to `/usr/bin/wp core is-installed`.*)

You can pass one or more checks into Puppet for this.
