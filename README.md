# Personal Dotfiles

A modern development environment configuration featuring Neovim, Tmux, and productivity tools optimized for coding and writing workflows.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [What's Included](#whats-included)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [File Structure](#file-structure)
- [Quick Troubleshooting](#quick-troubleshooting)

## Overview

This dotfiles repository contains my personal development environment setup, designed for:
- **Coding**: Modern Neovim configuration with LSP, autocompletion, and fuzzy finding
- **Writing**: Doom Emacs with org-mode (separate setup)
- **Terminal multiplexing**: Tmux with custom session management
- **Version control**: Jujutsu (JJ) configuration for modern Git workflows

## Quick Start

```bash
# Clone the repository
git clone https://github.com/weikanglim/dotfiles.git ~/.dotfiles

# Install configurations (creates symlinks)
cd ~/.dotfiles
./install.sh
```

## What's Included

### 🚀 Neovim Configuration
- **Base**: Kickstart.nvim foundation
- **LSP Support**: Lua, Zig, YAML language servers
- **Fuzzy Finding**: Telescope for files, grep, and more
- **Autocompletion**: nvim-cmp with snippet support
- **Git Integration**: Gitsigns for diff highlighting
- **Syntax Highlighting**: Treesitter for better code understanding
- **Theme**: Tokyo Night colorscheme

**Key Features:**
- Leader key: `;` (semicolon)
- Vim-style navigation with helpful arrow key reminders
- Automatic LSP server installation via Mason
- Format on save with conform.nvim
- Diagnostic navigation and error highlighting

### 🖥️ Tmux Configuration
- **Prefix**: `Ctrl-a` (instead of default `Ctrl-b`)
- **Navigation**: Vim-style pane navigation (`h`, `j`, `k`, `l`)
- **Sessions**: Integrated with custom sessionizer script
- **Copy Mode**: Vim bindings for text selection

### 🎯 Tmux Sessionizer
Smart project session management:
- Quickly switch between projects in `~/personal` and `~/repos`
- Automatic session naming based on directory
- Fuzzy finding with fzf integration

### 🌿 Jujutsu (JJ) Configuration
Modern version control setup:
- Default to `log` command for better workflow visibility
- Custom aliases for bookmark management
- User configuration for Wei Lim

## Installation

### Prerequisites

Ensure you have the following installed:
- **Neovim** (>= 0.9)
- **Git**
- **Tmux**
- **FZF** (for sessionizer)
- **Ripgrep** (for Telescope grep functionality)
- **A Nerd Font** (for icons in Neovim)

### Optional Dependencies
- **Jujutsu (JJ)** - for version control
- **Make** - for some Neovim plugin builds
- **Node.js** - for some LSP servers

### Installation Steps

1. **Backup existing configurations** (recommended):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.tmux.conf ~/.tmux.conf.backup
   ```

2. **Clone and install**:
   ```bash
   git clone https://github.com/weikanglim/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ./install.sh
   ```

3. **First Neovim launch**:
   - Open Neovim: `nvim`
   - Wait for Lazy.nvim to install plugins automatically
   - LSP servers will be installed via Mason on first use

## Usage

### Neovim Key Bindings

| Key | Action | Description |
|-----|---------|-------------|
| `;ff` | Find Files | Fuzzy find files in current directory |
| `;fg` | Live Grep | Search text in all files |
| `;fb` | Buffers | Switch between open buffers |
| `;fh` | Help Tags | Search Neovim help |
| `gd` | Go to Definition | Jump to symbol definition |
| `gr` | References | Find all references |
| `;ca` | Code Action | Show available code actions |
| `;x` | Format | Format current buffer |
| `K` | Hover | Show documentation |

### Tmux Key Bindings

| Key | Action |
|-----|---------|
| `Ctrl-a` | Prefix key |
| `Ctrl-a f` | Open sessionizer |
| `Ctrl-a h/j/k/l` | Navigate panes |
| `Ctrl-a r` | Reload tmux config |

### Sessionizer Workflow

```bash
# Open sessionizer (from tmux: Ctrl-a f)
# Or directly:
~/.local/bin/tmux-sessionizer

# Or with specific directory:
~/.local/bin/tmux-sessionizer ~/my-project
```

## Customization

### Adding New LSP Servers

Edit `.config/nvim/init.lua` and add to the `servers` table:

```lua
local servers = {
  -- existing servers...
  your_server = {
    settings = {
      -- server-specific settings
    }
  }
}
```

### Modifying Keymaps

Neovim keymaps are defined in `init.lua`. Add custom bindings:

```lua
vim.keymap.set('n', '<leader>your_key', your_function, { desc = 'Your description' })
```

### Tmux Customization

Edit `.tmux.conf` to modify:
- Status bar appearance
- Key bindings
- Pane/window behavior

## File Structure

```
~/.dotfiles/
├── .config/
│   ├── nvim/           # Neovim configuration
│   │   ├── init.lua    # Main config file
│   │   └── lua/        # Additional Lua modules
│   └── jj/             # Jujutsu configuration
│       └── config.toml
├── .local/
│   └── bin/
│       └── tmux-sessionizer  # Session management script
├── .tmux.conf          # Tmux configuration
├── MANIFEST            # Files tracked for installation
└── install.sh          # Installation script
```

## Quick Troubleshooting

### Common Issues

**LSP not working in Neovim:**
- Check `:Mason` for server installation status
- Run `:checkhealth` to diagnose issues

**Tmux sessionizer not working:**
- Ensure fzf is installed: `which fzf`
- Check script permissions: `chmod +x ~/.local/bin/tmux-sessionizer`
- Create required directories: `mkdir -p ~/personal ~/repos`

**Installation conflicts:**
- The install script will warn about existing files
- Backup existing configs before running: `mv ~/.config/nvim ~/.config/nvim.backup`

For detailed troubleshooting, see the [Installation Guide](docs/INSTALL.md#troubleshooting).

## Documentation

Detailed documentation is available in the `docs/` directory:

- **[Installation Guide](docs/INSTALL.md)** - Complete setup instructions with prerequisites
- **[Neovim Configuration](docs/NVIM.md)** - Detailed Neovim setup and customization
- **[Tmux Setup](docs/TMUX.md)** - Tmux configuration and session management
- **[Jujutsu (JJ) Guide](docs/JJ.md)** - Modern version control workflow
- **[Development Workflows](docs/WORKFLOWS.md)** - Practical usage patterns and productivity tips

## Related Configurations

This setup pairs well with:
- **Doom Emacs** for org-mode writing workflows
- **Alacritty/Kitty** terminal emulator with ligature support
- **Zsh/Fish** shell with completion

## License

Personal configuration files - feel free to use and modify as needed.