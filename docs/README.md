# Documentation Index

Comprehensive documentation for the dotfiles configuration.

## Getting Started

1. **[Installation Guide](INSTALL.md)** - Start here for complete setup
   - Prerequisites and dependencies
   - Step-by-step installation process
   - Verification and troubleshooting

## Core Components

2. **[Neovim Configuration](NVIM.md)** - Modern editor setup
   - LSP integration and language servers
   - Telescope fuzzy finding
   - Plugin management with Lazy.nvim
   - Customization guide

3. **[Tmux Setup](TMUX.md)** - Terminal multiplexing
   - Custom key bindings and navigation
   - Session management workflow
   - Tmux sessionizer for project switching

4. **[Jujutsu (JJ) Guide](JJ.md)** - Modern version control
   - JJ vs Git comparison
   - Configuration and workflow
   - Git compatibility and migration

## Usage and Workflows

5. **[Development Workflows](WORKFLOWS.md)** - Practical usage patterns
   - Daily development routines
   - Multi-project management
   - Feature development process
   - Team collaboration patterns

## Quick Reference

### Key Bindings

| Tool | Key | Action |
|------|-----|--------|
| **Tmux** | `Ctrl-a f` | Open sessionizer |
| **Neovim** | `;ff` | Find files |
| **Neovim** | `;fg` | Search text |
| **Neovim** | `gd` | Go to definition |

### Common Commands

```bash
# Install dotfiles
cd ~/.dotfiles && ./install.sh

# Check Neovim health
nvim +checkhealth

# List tmux sessions
tmux list-sessions

# View JJ log
jj log
```

## Contributing

Found an issue or have an improvement? The documentation lives in the main repository and can be updated through pull requests.

## Support

Each documentation file includes troubleshooting sections. For additional help:
- Check the specific tool's documentation
- Review configuration files in the repository
- Use built-in help systems (`:help` in Neovim, `jj help`, etc.)