# GitHub Action: Run rubocop-linter

[![](https://img.shields.io/github/license/monclubsportif/web-linter)](./LICENSE)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/monclubsportif/web-linter?logo=github&sort=semver)](https://github.com/monclubsportif/web-linter/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

You can create the [eslint config](https://eslint.org/docs/user-guide/configuring/) and this action uses that
config too.

```yml
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  eslint:
    name: Run web-linter
    runs-on: ubuntu-latest
    steps:
      - name: Checkout (pull request)
        if: github.event_name == 'pull_request'
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.ref }}
      - name: Checkout (push)
        if: github.event_name != 'pull_request'
        uses: actions/checkout@v2
      - uses: ruby/setup-ruby@v1.101.0
      - name: Run eslint
        uses: monclubsportif/web-linter@v1
      - name: Add & Commit
        uses: EndBug/add-and-commit@v9.0.0
        with:
          message: 'web-linter commit'
```

## Inputs

### `github_token`

`GITHUB_TOKEN`. Default is `${{ github.token }}`.

**If you use the default value, make sure the
[repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#setting-the-permissions-of-the-github_token-for-your-repository)
or the
[organisation](https://docs.github.com/en/organizations/managing-organization-settings/disabling-or-limiting-github-actions-for-your-organization#setting-the-permissions-of-the-github_token-for-your-organization)
have the `Read and write permissions` enabled.**

### `eslint_files`

Optional. The files to lint. Default value is `{**/*,*}.{js,ts,jsx,tsx,html,vue}`.

### `eslint_flags`

Optional. [Eslint flags](https://eslint.org/docs/user-guide/command-line-interface). (eslint `<eslint_flags>`).

### `max_warnings`

Optional. The warning threshold of eslint. Default "-1". More information
[here](https://eslint.org/docs/user-guide/command-line-interface#--max-warnings).

### `fail_on_error`

Optional. Exit code for web-linter when errors are found [`true`, `false`]. Default is `false`.

### `workdir`
Optional. The directory where the action is executed. Default is `.`.

### `skip_install`

Optional. Do not install the node packages. Default is `false`.

### `use_bundler`

Optional. The runner that will execute eslint (e.g. `yarn`, `npm`, `npx`). Default is `detect`, which will decide
between `yarn`, if the file `yarn.lock` is present, and `npm`.
