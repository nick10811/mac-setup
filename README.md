# mac_setup

![GitHub](https://img.shields.io/github/license/nick10811/mac_setup)
![CI](https://img.shields.io/github/actions/workflow/status/nick10811/mac-setup/verify.yaml)

Automatically sets up a Mac with Nick's recommended apps and configuration.

## Before You Start

**1. Choose your apps** — open `Setupfile` and:
- Update `name` and `email` at the top
- Delete any line for an app you don't want installed

Every app has an inline description. The file represents Nick's recommended defaults — nothing is mandatory.

**2. Run `make all`**

```bash
make all
```

That's it. `make all` installs Homebrew, Oh My Zsh, every app you kept in `Setupfile`, configures Git, and sets up your shell plugins.

To also apply macOS system preferences (Dock, Finder, Trackpad, Terminal):

```bash
make preferences
```

## Setupfile Format

Each line is `keyword "value"  # description`. Delete lines you don't want — the keyword tells `make all` what to do:

| Keyword | Action |
|---------|--------|
| `name` | Set Git global user.name |
| `email` | Set Git global user.email |
| `gitignore` | Download `.gitignore_global` from gitignore.io |
| `plugin` | Install Oh My Zsh plugin |
| `brew` | `brew install` |
| `cask` | `brew install --cask` |
| `pip` | `pip install` |
| `run` | Run a shell command (e.g. `pod setup`) |
