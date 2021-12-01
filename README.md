# Example Python Repo

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

This repo is the source code of example python repo

----

## For developers

### How to use

- create a repo with this template
- clone the repo
- install ci tools `make install-ci`
- add your source code
- bump init version `make bump-and-push-version`

### Code style

Please install git hooks.

```bash
# install ci tools for local
make install-ci
# bump version
make bump
# bump version and push
make bump-and-push-version
# Others
make help
```

### Commit style

Please use conventional commits at both commit messages and PR title for sake of changelog and version bump.

```bash
# Feature
git commit -m "feat: this is description of a feature"
# Bugfix
git commit -m "fix: this is description of a bugfix"
```

Tools for writing longer commit message

- (pip) commitizen
- (VS Code) knisterpeter.vscode-commitizen
- (VS Code) kvivaxy.vscode-conventional-commits

### Setup GitHub Repo

- Only allow rebase
- Auto delete merged branch
