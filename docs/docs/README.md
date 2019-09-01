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
2. Run `yarn install`
3. Run `yarn docs:dev` and open [http://localhost:8080/]( http://localhost:8080/) in a browser.
4. Run `yarn docs:build` to build static assets.
