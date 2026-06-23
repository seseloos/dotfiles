# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for macOS. Configurations are manually symlinked — there is no automated install script. Each subdirectory maps to its target location under `~/.config/` or `~` depending on the tool.

| Directory / File | Target |
|---|---|
| `nvim/` | `~/.config/nvim/` |
| `kitty/` | `~/.config/kitty/` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `.zshrc` | `~/.zshrc` |
| `.gitmessage` | `~/.gitmessage` |

## Makefile commands

```sh
make update-ollama      # Pull latest versions of all tracked Ollama models
make update-homebrew    # Run brew update && brew upgrade
```

## Starting a dev session

The `tmux/tmuxinator/projects.yml` template launches a project session. Usage (from any project directory):

```sh
tmuxinator start projects -n "${PWD##*/}" $(pwd)
```

## Neovim architecture

Config lives in `nvim/` and uses the namespace `seseloos`. Load order:

1. `nvim/init.lua` — requires `seseloos`
2. `nvim/lua/seseloos/init.lua` — loads `settings`, `plugins`, `mappings`, `keymap`, `markdown`
3. `nvim/after/plugin/` — per-plugin configuration files, loaded after all plugins are initialized

Plugin manager is **lazy.nvim** (auto-bootstrapped). The lock file is `nvim/lazy-lock.json`. LSP servers and formatters are managed by **Mason** (`after/plugin/mason.lua` and `after/plugin/lsp.lua`).

Leader key is `,` (comma).

## Conventions

- **Theme**: Catppuccin Mocha across all tools (Neovim, Kitty, Tmux, WezTerm)
- **Font**: JetBrainsMono Nerd Font Mono at 14pt
- **Commits**: Conventional Commits format — the `.gitmessage` template is the reference
- **Vim-style navigation**: `h/j/k/l` pane movement in Tmux mirrors Neovim muscle memory
