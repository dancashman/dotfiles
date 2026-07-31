# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup / Installation

Run the setup script from the repo root to create symlinks and config directories:

```sh
./setup.sh
```

This script:
- Creates `~/.config/{zellij,alacritty,ghostty}` directories
- Copies `starship.toml` to `~/.config/starship.toml`
- Symlinks configs to their expected system locations (zshrc, nvim, alacritty, wezterm, ghostty, zellij, hyper, aerospace, gitconfig)

Note: `git/.gitconfig` is symlinked to `~/.gitconfig` by `setup.sh` — always run `setup.sh` on a new machine before committing, otherwise git falls back to a machine-derived author (`user@hostname`) instead of the configured identity.

There is no Makefile, no build system, and no test suite.

## Repository Structure

This is a personal dotfiles repo managed via a manual symlink script (no GNU Stow or chezmoi).

| Path | Purpose |
|------|---------|
| `setup.sh` | Installs dotfiles by creating symlinks |
| `zsh/zshrc` | Main zsh config — sources `functions.sh` and `keybindings.sh` from same dir |
| `zsh/plugins/` | Git-tracked zsh plugins (autosuggestions, syntax-highlighting, kube-ps1) |
| `nvim/` | Neovim config based on Kickstart.nvim, using lazy.nvim for plugins |
| `nvim/lua/custom/plugins/` | User-added plugin configs (catppuccin, neo-tree, trouble, etc.) |
| `git/.gitconfig` | Global git config for Dan Cashman (djcashman@gmail.com) |
| `tmux/` | Tmux config with platform-specific keybinding files (mac/ubuntu/rhel) |
| `zellij.kdl` | Zellij multiplexer config with fully custom keybindings |
| `ghostty` | Ghostty terminal config (Ayu Mirage theme, JetBrains Mono font) |
| `wezterm/` | WezTerm config split into `config/init.lua`, `fonts.lua`, `keys.lua` |
| `js/` | Legacy JS tool configs (jshint, jscs, jsbeautify) |

## Neovim Architecture

The `nvim/` config is based on [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim):
- **Plugin manager**: lazy.nvim (auto-bootstrapped in `init.lua`)
- **LSP**: nvim-lspconfig + Mason for tool installation
- **Completion**: nvim-cmp
- **Fuzzy finding**: Telescope
- **Syntax**: Treesitter
- **Leader key**: `<space>`
- Custom plugins live in `nvim/lua/custom/plugins/` and are auto-loaded

To add a new plugin, create a `.lua` file in `nvim/lua/custom/plugins/` returning a lazy.nvim plugin spec.

## Zsh Config

`zsh/zshrc` sets up:
- PATH for Go, Node (NVM), Homebrew, Poetry
- Aliases: `k` → kubectl, `vim` → nvim
- Starship prompt, Atuin history, Fig integration
- Custom keybindings: `^k` (cd ..), `^g` (git add/commit/push), `^h` (home), `^s` (sudo prefix)
