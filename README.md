# dotfiles

Personal macOS dotfiles configured for the **Colemak keyboard layout**.

## Install

```sh
git clone git@github.com:dancashman/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./setup.sh
```

`setup.sh` creates symlinks from this repo to their expected system locations and sets up config directories under `~/.config/`.

## What's included

| Tool | Config | Notes |
|------|--------|-------|
| **Zsh** | `zsh/zshrc` | Plugins, PATH, aliases, Starship, Atuin |
| **Neovim** | `nvim/` | Kickstart.nvim base, lazy.nvim plugins |
| **Zellij** | `zellij.kdl` | Terminal multiplexer, Catppuccin Mocha theme |
| **Ghostty** | `ghostty` | Ayu Mirage theme, JetBrains Mono |
| **Tmux** | `tmux/` | Fallback multiplexer config |
| **Alacritty** | `alacritty.yml` | Launches into Zellij by default |
| **WezTerm** | `wezterm/` | Modular Lua config |
| **Starship** | `starship.toml` | Prompt: git, k8s context, Go, Python, Lua, Rust |
| **Git** | `git/.gitconfig` | Aliases, merge config |

## Keybindings (Colemak)

Navigation uses `h/n/e/i` = left/down/up/right throughout (matching Colemak home-row positions).

### Zsh

| Key | Action |
|-----|--------|
| `Ctrl+e` | `cd ..` |
| `Ctrl+g` | `git add -A && git commit && git push` (type message first as buffer) |
| `Ctrl+h` | `cd ~` |
| `Ctrl+s` | Prepend `sudo` to current buffer |

### Neovim

Leader key is `<Space>`.

| Key | Action |
|-----|--------|
| `n/e` | Down/up (Colemak) |
| `i` | Right (normal mode) |
| `j` | Enter insert mode |
| `k/K` | Next/prev search result (centered) |
| `l/L` | End of word/WORD |
| `nn` | Escape (insert mode) |
| `Ctrl+h/n/e/i` | Move between splits |
| `<leader>e` | Toggle file tree (Neo-tree) |
| `<leader>vs` / `<leader>hs` | Vertical / horizontal split |
| `<leader>t` | New tab; `<leader>tl` / `<leader>th` = next/prev |
| `<leader>y` | Copy to system clipboard |
| `<leader>s` | Replace word under cursor (project-wide) |
| `E/N` (visual) | Move selection up/down |

### Zellij

Mode trigger keys: `Ctrl+p` (pane), `Ctrl+n` (resize), `Ctrl+y` (tab), `Ctrl+s` (scroll), `Ctrl+h` (move), `Ctrl+g` (lock).

Within each mode, `h/n/e/i` = left/down/up/right. Additional pane bindings:

| Key | Action |
|-----|--------|
| `a` | New pane |
| `d` / `r` | New pane down / right |
| `x` | Close pane |
| `f` | Fullscreen toggle |
| `Alt+h/n/e/i` | Move focus or tab (from any mode) |

### Ghostty

| Key | Action |
|-----|--------|
| `Ctrl+p > s > v` | New split right |
| `Ctrl+p > s > h` | New split down |
| `Ctrl+p > h/l/j/k` | Navigate splits |
| `Ctrl+t > n` | New tab |
| `Ctrl+t > l/h` | Next/prev tab |

## Neovim plugins

Managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Custom plugins live in `nvim/lua/custom/plugins/` — add a `.lua` file returning a lazy spec to install anything new.

Key plugins: catppuccin · neo-tree · telescope · treesitter · nvim-cmp · nvim-lspconfig · Mason · conform · gitsigns · trouble · wakatime · which-key

## Zsh plugins

Bundled as git submodules in `zsh/plugins/`:
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `kube-ps1` / `kubectl-prompt`
