# git-pyclone

[![GitHub Actions Demo](https://github.com/rimij405/git-pyclone/actions/workflows/github-actions-demo.yml/badge.svg?branch=main)](https://github.com/rimij405/git-pyclone/actions/workflows/github-actions-demo.yml)

A CLI tool to clone repositories from a git remote.

## Features

- Modern CLI with [Typer][typer].
- Consistent bug detection, linting, and formatting with [`pre-commit`][precommit] hooks.
- Test suite using [`pytest`][pytest].

## Quickstart

## Local Development

To develop locally, clone this repository:

```bash
# If using HTTPS:
https://github.com/rimij405/git-pyclone.git

# If using SSH:
git clone git@github.com:rimij405/git-pyclone.git

# If using the GitHub CLI:
gh repo clone rimij405/git-pyclone
```

Run tests using [`pytest`][]:

```bash
make test
```

Run [`pre-commit`][precommit] hooks using:

```bash
make pre-commit
```

<!-- LINKS -->

[typer]: https://typer.tiangolo.com/
[poetry]: https://python-poetry.org/
[precommit]: https://pre-commit.com/
[pytest]: https://docs.pytest.org/
