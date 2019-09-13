# Documentation

## VuePress

We've used [VuePress](https://v1.vuepress.vuejs.org) to generate the documentation for Puppet WP.

You can contribute updates to the documentation on any page by clicking on the `Suggest an edit!` links in the footer
of any of the pages.

## VuePress Configuration

The title, navigation, sidebar and repository links are all managed in `docs/.vuepress/config.js`.

## Documentation Installation

If you'd like to contribute and preview your contributions before you submit a Pull Request to Puppet WP you can do
the following:

1. Clone the repository to your computer:
    ``` git
        git clone https://github.com/Chassis/puppet-wp <your-folder>
    ```
1. Run `cd docs` in a terminal.
1. Run `yarn install`
1. Run `yarn docs:dev` and open [http://localhost:8080/]( http://localhost:8080/) in a browser.
1. Run `yarn docs:build` to build static assets.

## Documentation Deployment

The [documentation](https://chassis.github.io/puppet-wp/) is hosted on Github Pages and this is automatically [deployed](https://github.com/Chassis/puppet-wp/blob/master/.travis.yml#L9-L23) with [TravisCI](https://travis-ci.org/).

The `GITHUB_TOKEN` is a [personal access token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line) which can be created on Github. Once created, this token should be copied into the Environmental Variables settings on TravisCI.

