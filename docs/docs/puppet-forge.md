# Puppet Forge

We also publish this module on Puppet Forge. [https://forge.puppet.com/chassis/puppet_wp](https://forge.puppet.com/chassis/puppet_wp)

## Requirements

To publish the module on Puppet Forge you need to install the [Puppet Development Kit](https://puppet.com/docs/pdk/1.x/pdk.html)

### Installation on Mac OS X

Run `brew cask install puppetlabs/puppet/pdk`.

### Installation on Linux

Refer to the installation instructions for your [Linux distrobution](https://puppet.com/docs/pdk/1.x/pdk_install.html#install-pdk-linux).

### Installation on Windows

Download the [installation](https://puppet.com/download-puppet-development-kit).

## Publishing the module

Open a terminal and run the following commands:

1. Run `pdk new module` and answer the questions as follows:
    ```
    [Q 1/4] Summarize the purpose of this module in a single sentence.
    This helps other Puppet users understand what the module does.
    --> This modules manages your WordPress sites using WP-CLI, allowing you to install your site, manage plugins, themes, options and more.
    
    [Q 2/4] If there is a source code repository for this module, enter the URL here.
    Skip this if no repository exists yet. You can update this later in the metadata.json.
    --> https://github.com/Chassis/puppet_wp/
    
    [Q 3/4] If there is a URL where others can learn more about this module, enter it here.
    Optional. You can update this later in the metadata.json.
    --> https://chassis.github.io/puppet_wp/
    
    [Q 4/4] If there is a public issue tracker for this module, enter its URL here.
    Optional. You can update this later in the metadata.json.
    --> https://github.com/Chassis/puppet_wp/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc
    ```
2. Increment the version number in `puppet_wp/metadata.json`.
3. Run `pdk build`.
