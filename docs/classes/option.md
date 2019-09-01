# Option

* [Description](/classes/option.html#description)
* [Attributes](/classes/option.html#attributes)

## Description

Retrieves and sets site options, including plugin and WordPress settings.

## Attributes
``` puppet
	wp::option { 'resource title':
		location => # The location to run the command.
        key      => # The name of the option to add.
        value    => # The value of the option to add.
        ensure   => # What state the option should be in.
	}
```

### location

The directory from which to run the command. If this directory does not exist, the command will fail.

### key

(*If omitted, this attribute’s value defaults to the resource’s title.*)

The name of the option to add.

### value

(*If omitted, this attribute’s value defaults undefined.*)

The value of the option to add.

### ensure
(*If omitted, this attribute’s value defaults to present*)

Values: `present`, `equal`, `absent`.

#### Examples

``` puppet
    wp::option 'Add and set Foo to Bar' {
        location => '/vagrant',
        key      => 'Foo',
        value    => 'Bar' ,
    }
```

``` puppet
    wp::option 'Update Foo to Fighters' {
        location => '/vagrant',
        key      => 'Foo',
        value    => 'Fighters',
        ensure   => equal
    }
```

``` puppet
    wp::option 'Delete Foo' {
        location => '/vagrant',
        key      => 'Foo',
        ensure   => abest
    }
```
