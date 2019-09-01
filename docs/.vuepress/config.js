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
                    ['/classes/cli', 'CLI'],
                    ['/classes/command', 'Command'],
                    ['/classes/option', 'Option'],
                    ['/classes/params', 'Params'],
                    ['/classes/plugin', 'Plugin'],
                    ['/classes/rewrite', 'Rewrite'],
                    ['/classes/site', 'Site'],
                    ['/classes/theme', 'Theme'],
                ],
            },
            {
                title: 'Docs',
                collapsable: false,
                children: [
                    [ '/docs/', 'Documentation' ]
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
