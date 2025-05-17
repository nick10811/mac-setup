# mac_setup

![GitHub](https://img.shields.io/github/license/nick10811/mac_setup)
![CI](https://img.shields.io/github/actions/workflow/status/nick10811/mac-setup/verify.yaml)

This is a tool that setup the Mac environment automatically. It installs all necessary packages that are recommended by Nick. [You can read my article to get more information.](https://nick10811.github.io/2019/09/25/my-mac-environment/)

## Before You Start

Open `Makefile` and update these two variables before running anything:

```makefile
NAME  = "Your Name"    # ← your Git username
EMAIL = "your@email.com"  # ← your Git email
```

If you don't update these, `make configure` will set your global Git identity to the literal strings above.

You can also optionally adjust:
- `GITIGNORE` — template combination for `.gitignore_global` (generate at [toptal.com/developers/gitignore](https://www.toptal.com/developers/gitignore))
- `PLUGINS` — list of Oh My Zsh plugins to enable

## Usage

Install everything (software + config + macOS preferences):

```bash
make all
make preferences
```

### Individual Targets

| Target | Description |
|--------|-------------|
| `make setup` | Install shell tools (Homebrew, iTerm2, Oh My Zsh, plugins, Vim config) |
| `make configure` | Set up Git global config and `.gitignore_global` |
| `make install-dev` | General dev tools (VS Code, Postman, Fork, etc.) |
| `make install-dev-bed` | Backend/DevOps tools (Docker, k9s, AWS CLI, MongoDB, etc.) |
| `make install-dev-ios` | iOS dev tools (CocoaPods, Carthage, SQLite) |
| `make install-design` | Design tools (Figma) |
| `make install-productivity` | Productivity tools (bat, Notion, Edge, etc.) |
| `make install-teamwork` | Collaboration tools (Zoom, Slack) |
| `make install-fun` | Entertainment (Spotify) |
| `make preferences` | Apply macOS system preferences (Dock, Finder, Trackpad, Terminal) |
| `make apps` | Install software only — no config files written (for use by dotfiles) |
