# Installation Guide

Comprehensive setup guide for the dotfiles configuration.

## Overview

This guide walks through setting up the complete development environment with all dependencies and configurations.

## System Requirements

### Operating System
- **Linux** (Ubuntu 20.04+, Arch Linux, etc.)
- **macOS** (10.15+)
- **Windows** (WSL2 recommended)

### Minimum Requirements
- 4GB RAM
- 2GB free disk space
- Internet connection for downloads

## Quick Install (Recommended)

For most users, this one-liner will handle the complete setup:

```bash
curl -fsSL https://raw.githubusercontent.com/weikanglim/dotfiles/main/scripts/install.sh | bash
```

*Note: Always review scripts before running. See [Manual Installation](#manual-installation) for step-by-step process.*

## Manual Installation

### Step 1: Install Prerequisites

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install -y \
  git \
  curl \
  tmux \
  neovim \
  fzf \
  ripgrep \
  build-essential \
  nodejs \
  npm \
  xclip
```

#### macOS
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install \
  git \
  tmux \
  neovim \
  fzf \
  ripgrep \
  node \
  npm
```

#### Arch Linux
```bash
sudo pacman -S \
  git \
  tmux \
  neovim \
  fzf \
  ripgrep \
  nodejs \
  npm \
  xclip \
  base-devel
```

### Step 2: Install Optional Dependencies

#### Jujutsu (Recommended)
```bash
# Using Cargo (Rust)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cargo install jj-cli

# Or using package manager
# Ubuntu: cargo install jj-cli
# macOS: brew install jj
# Arch: yay -S jujutsu
```

#### Nerd Font (Recommended for icons)
```bash
# Download and install a Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Example: JetBrains Mono Nerd Font
curl -fOL https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf

# Refresh font cache
fc-cache -fv
```

### Step 3: Clone and Install Dotfiles

```bash
# Clone the repository
git clone https://github.com/weikanglim/dotfiles.git ~/.dotfiles

# Navigate to dotfiles directory
cd ~/.dotfiles

# Backup existing configurations (recommended)
mkdir -p ~/.config-backup
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.config-backup/
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config-backup/
[ -d ~/.config/jj ] && mv ~/.config/jj ~/.config-backup/

# Run installation script
./install.sh
```

### Step 4: Set Up Project Directories

Create directories for the tmux sessionizer:

```bash
mkdir -p ~/personal ~/repos
```

### Step 5: First Neovim Launch

```bash
# Start Neovim to trigger plugin installation
nvim

# Wait for Lazy.nvim to install all plugins
# This may take a few minutes on first launch
```

### Step 6: Terminal Configuration

#### Update Terminal Font
1. Set terminal font to a Nerd Font (e.g., JetBrains Mono Nerd Font)
2. Enable font ligatures if supported
3. Set font size to 12-14pt for optimal readability

#### Terminal Emulator Recommendations
- **Alacritty**: Fast, GPU-accelerated
- **Kitty**: Feature-rich with good font support
- **GNOME Terminal**: Good default choice for Linux
- **iTerm2**: Excellent choice for macOS

## Verification

### Test Installation

Run these commands to verify everything is working:

```bash
# Test Neovim
nvim --version

# Test Tmux
tmux -V

# Test FZF
echo "test" | fzf

# Test Ripgrep
rg --version

# Test JJ (if installed)
jj --version

# Test sessionizer
~/.local/bin/tmux-sessionizer --help
```

### Check Neovim Setup

```bash
# Launch Neovim and run health check
nvim +checkhealth
```

Look for:
- ✓ LSP servers installed
- ✓ Treesitter parsers available
- ✓ Telescope dependencies working

### Test Tmux Configuration

```bash
# Start tmux
tmux

# Test prefix key (should show tmux status)
# Press: Ctrl-a ?

# Test sessionizer
# Press: Ctrl-a f
```

## Customization After Installation

### Configure Git (if using JJ with Git remotes)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Set Up Shell Integration

#### Bash
Add to `~/.bashrc`:
```bash
# Tmux auto-start (optional)
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi

# FZF integration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
```

#### Zsh
Add to `~/.zshrc`:
```bash
# Tmux auto-start (optional)
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi

# FZF integration
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
```

### Additional Tools Integration

#### Doom Emacs (for org-mode writing)
```bash
# Install Doom Emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

#### Development Tools
```bash
# Language-specific tools
npm install -g typescript-language-server
npm install -g yaml-language-server
cargo install zls  # Zig language server
```

## Troubleshooting

### Common Issues

#### Neovim Plugins Not Loading
```bash
# Clear plugin cache and reinstall
rm -rf ~/.local/share/nvim
nvim +Lazy sync
```

#### Tmux Sessionizer Not Working
```bash
# Check FZF installation
which fzf

# Verify script permissions
chmod +x ~/.local/bin/tmux-sessionizer

# Create required directories
mkdir -p ~/personal ~/repos
```

#### LSP Servers Not Installing
```bash
# Manually install via Mason
nvim +"Mason" +qa

# Or install system-wide
npm install -g typescript-language-server
```

#### Font Icons Not Showing
1. Ensure Nerd Font is installed
2. Set terminal font to Nerd Font
3. Restart terminal application
4. Test with: `echo ""`

### Getting Help

```bash
# Neovim help
nvim +help

# Tmux help
tmux list-keys

# JJ help
jj help

# Check health
nvim +checkhealth
```

## Updating

### Update Dotfiles
```bash
cd ~/.dotfiles
git pull origin main
./install.sh
```

### Update Neovim Plugins
```bash
nvim +Lazy update
```

### Update System Dependencies
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# macOS
brew update && brew upgrade

# Arch Linux
sudo pacman -Syu
```

## Advanced Setup

### Multiple Machines Sync

Use Git to synchronize across machines:

```bash
# Make local changes
cd ~/.dotfiles
git add .
git commit -m "Local customizations"
git push origin main

# On other machine
cd ~/.dotfiles
git pull origin main
./install.sh
```

### Docker Development

Create development containers with dotfiles:

```dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y git curl

# Copy and install dotfiles
COPY . /root/.dotfiles
WORKDIR /root/.dotfiles
RUN ./install.sh

# Set working directory
WORKDIR /workspace
```

### Remote Development

Set up for SSH/remote development:

```bash
# Copy dotfiles to remote server
scp -r ~/.dotfiles user@server:~/
ssh user@server "cd ~/.dotfiles && ./install.sh"
```

This installation guide provides everything needed to set up a complete, productive development environment with modern tools and workflows.