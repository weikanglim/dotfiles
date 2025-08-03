# Personal Dotfiles

My development environment setup with Neovim, Tmux, and productivity tools.

## What's Included

**Neovim**: Kickstart.nvim-based config with LSP (Lua, Zig, YAML), Telescope fuzzy finding, autocompletion, and Tokyo Night theme. Leader key is `;`.

**Tmux**: Prefix `Ctrl-a`, vim-style navigation, custom sessionizer for project switching between `~/personal` and `~/repos`.

**Jujutsu**: Modern Git alternative with sensible defaults and aliases.

## Installation

Prerequisites: Neovim (≥0.9), Git, Tmux, FZF, Ripgrep, Nerd Font

```bash
git clone https://github.com/weikanglim/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Usage

**Neovim**: `;ff` (find files), `;fg` (grep), `gd` (go to definition), `;x` (format)

**Tmux**: `Ctrl-a f` (sessionizer), `Ctrl-a h/j/k/l` (navigate panes)

**Sessionizer**: `~/.local/bin/tmux-sessionizer` or from tmux with `Ctrl-a f`

## Documentation

Detailed guides in `docs/`:
- [Installation](docs/INSTALL.md) - Setup and troubleshooting
- [Neovim](docs/NVIM.md) - Configuration details
- [Tmux](docs/TMUX.md) - Session management
- [Jujutsu](docs/JJ.md) - Version control workflow
- [Workflows](docs/WORKFLOWS.md) - Usage patterns