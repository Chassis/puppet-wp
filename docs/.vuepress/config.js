module.exports = {
    title: 'Puppet WP',
    description: 'This module enables the easy use of WP CLI to control your WordPress site through Puppet manifests. It provides an easy abstraction for common WP CLI commands as well as installing the WP CLI binaries as needed.',
    base: '/puppet-wp/',
    themeConfig: {
        repo: 'chassis/puppet-wp',
        editLinks: true,
        docsBranch: 'master',
        lastUpdated: 'Last Updated',
        editLinkText: 'Suggest an edit!',
        nav: [
            {text: 'Home', link: '/' },
            {text: 'Installation', link: '/installation/' },
            {text: 'Classes', link: '/classes/' },
        ],
        sidebar: [
            {
                title: 'Installation',
                collapsable: false,
                children: [
                    [ '/installation/', 'Installation' ]
                ]
            },
            {
                title: 'Classes',
                collapsable: false,
                children: [
                    ['/classes/cap', 'Cap'],
                    ['/classes/cli', 'CLI'],
                    ['/classes/command', 'Command'],
                    ['/classes/command', 'Comment'],
                    ['/classes/command', 'Config'],
                    ['/classes/option', 'Option'],
                    ['/classes/params', 'Params'],
                    ['/classes/plugin', 'Plugin'],
                    ['/classes/rewrite', 'Rewrite'],
                    ['/classes/role', 'Role'],
                    ['/classes/site', 'Site'],
                    ['/classes/theme', 'Theme'],
                    ['/classes/user', 'User'],
                ],
            },
            {
                title: 'Docs',
                collapsable: false,
                children: [
                    [ '/docs/', 'Documentation' ],
                    [ '/docs/puppet-forge', 'Puppet Forge' ],
                ],
            },
            {
                title: 'Licence',
                collapsable: false,
                children: [
                    [ '/licence/', 'Licence' ]
                ],
            },
        ]
    }
}
