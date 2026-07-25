# ansible-workstation-config

Ansible playbook that provisions a development workstation on macOS and Debian-family Linux.

## Background

This repository is the single source of truth for provisioning a personal
development machine. A single playbook installs and configures packages, the
default shell, and dotfiles so a fresh machine can be brought to a known state
reproducibly.

It manages:

- Homebrew / Linuxbrew taps, formulae, and casks
- npm global CLI packages
- krew plugins for `kubectl`
- The default shell (zsh)
- Dotfiles, cloned and symlinked via [GNU Stow](https://www.gnu.org/software/stow/)

Package variables intentionally use two shapes, matching what each underlying
module expects:

- `dev_brew_taps`, `dev_brew_formulae`, `dev_brew_casks`, `dev_krew_plugins`
  are lists of strings. The Homebrew modules install a whole list in a single
  transaction, and Homebrew discourages version pinning, so plain names are
  idiomatic.
- `dev_npm_global_packages` is a list of dicts with `name` and an optional
  `version`, because `community.general.npm` takes name and version as separate
  parameters and per-package pinning is useful there.

## Install

Requires [Ansible](https://docs.ansible.com/) (core >= 2.21) and `make`, on
macOS (Apple Silicon) or a Debian-family Linux distribution. Homebrew/Linuxbrew
setup elevates with `sudo`.

Install the required roles and collections:

```sh
make install
```

## Usage

Apply the playbook to the local machine:

```sh
make run
```

The available `make` targets are:

| Target         | Description                                                 |
| -------------- | ----------------------------------------------------------- |
| `make install` | Install roles/collections from `requirements.yml`           |
| `make dry-run` | Check-mode run (`--check`); prompts for the become password |
| `make run`     | Apply the playbook to the local machine                     |
| `make lint`    | Run `ansible-lint`                                           |
| `make test`    | Run the Molecule scenario (requires Docker)                 |

Packages and configuration are declared in
[`roles/dev/defaults/main.yml`](roles/dev/defaults/main.yml):

```yaml
dev_brew_formulae:
  - git
  - node

dev_npm_global_packages:
  - name: "@augmentcode/auggie"
  - name: augment-open-proxy
    version: 1.0.3
```

## Maintainers

[@pedrobarco](https://github.com/pedrobarco)

## Contributing

This is a personal workstation configuration. Issues and pull requests are
welcome at
[pedrobarco/ansible-workstation-config](https://github.com/pedrobarco/ansible-workstation-config/issues).

## License

UNLICENSED © [@pedrobarco](https://github.com/pedrobarco)
