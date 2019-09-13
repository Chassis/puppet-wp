# Core

* [Description](/classes/site.html#description)
* [Attributes](/classes/site.html#attributes)

## Description

Downloads, installs, and manages a WordPress installation.

## Attributes
```puppet
    wp::core { 'resource title':
      url            => # The URL of the WordPress site.
      location       => # The location to run the command.
      siteurl        => # The URL of the WordPress site.
      sitename       => # The name of the site.
      admin_user     => # The site administrators username.
      admin_email    => # The site administrators email address.
      admin_password => # The site administrators password.
      network        => # If the site is a multisite.
      subdomains     => # Whether the multisite installation is in subfolders or subdomains.
      user           => # The user to run the installation as.
    }
```

### url

The URL of the site. e.g. `http://vagrant.local/`.

### location

The location to run the command. e.g. `/vagrant`.

### siteurl

The URL of the site including the protocol. e.g. `http://vagrant.local/`.

### sitename

(*If omitted, this attribute’s value defaults to `WordPress Site`.*)

The name of your site. e.g. `My Amazing Site`

### admin_user

(*If omitted, this attribute’s value defaults to `admin`.*)

The site administrator user name. e.g. `bronson`

### admin_email

(*If omitted, this attribute’s value defaults to `admin@example.com`.*)

The site administrators email address.

### admin_password

(*If omitted, this attribute’s value defaults to `password`.*)

The site administrators password: e.g. `aLbRY!Q9Qfh7YZ.h9jd!`

### network

(*If omitted, this attribute’s value defaults to `false`.*)

Whether or note the site is a multisite.

Values: `true`, `false`.

### subdomains

(*If omitted, this attribute’s value defaults to `false`.*)

Whether or not the multiste is setup as a subdomain. If this is set to `false` then WordPress multisite will be setup for subfolders.

Values: `true`, `false`.

### user

(*If omitted, this attribute’s value defaults to `www-data`.*)

The user to use to run the command.

#### Examples
Setup a normal WordPress installation.
```puppet
  wp::core { 'Setup a WordPress Site':
    url            => "http://vagrant.local/",
    location       => '/vagrant'
    sitename       => 'My Amazing Site',
    admin_user     => 'bronson',
    admin_email    => 'bronson@here.com',
    admin_password => 'aLbRY!Q9Qfh7YZ.h9jd!',
  }
```

Setup a WordPress multisite installation in subfolders.
```puppet
  wp::core { 'Setup a WordPress Site':
    url            => "http://vagrant.local/",
    location       => '/vagrant'
    sitename       => 'My Amazing Site',
    admin_user     => 'bronson',
    admin_email    => 'bronson@here.com',
    admin_password => 'aLbRY!Q9Qfh7YZ.h9jd!',
    network        => true,
  }
```

Setup a WordPress multisite installation with subdomains.
```puppet
  wp::core { 'Setup a WordPress Site':
    url            => "http://vagrant.local/",
    location       => '/vagrant'
    sitename       => 'My Amazing Site',
    admin_user     => 'bronson',
    admin_email    => 'bronson@here.com',
    admin_password => 'aLbRY!Q9Qfh7YZ.h9jd!',
    network        => true,
    subdomains     => true,
  }
```
