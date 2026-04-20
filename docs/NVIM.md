# Neovim Configuration

Detailed documentation for the Neovim setup in this dotfiles repository.

## Overview

This Neovim configuration is built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and provides a modern, LSP-enabled development environment with sensible defaults and powerful features.

## Philosophy

- **Minimal core, powerful extensions**: Start with a solid foundation and add features as needed
- **LSP-first**: Modern language server protocol integration for intelligent editing
- **Fuzzy everything**: Quick file navigation and searching with Telescope
- **Vim muscle memory**: Familiar keybindings with helpful modern additions

## Core Features

### Language Server Protocol (LSP)

Configured language servers:
- **Lua** (`lua_ls`) - Full Neovim API support with lazydev
- **Zig** (`zls`) - Systems programming support
- **YAML** (`yamlls`) - Configuration file editing

#### LSP Features
- **Go to definition**: `gd`
- **Find references**: `gr`
- **Hover documentation**: `K`
- **Code actions**: `<leader>ca`
- **Rename symbol**: `<leader>r`
- **Workspace symbols**: `<leader>ws`
- **Document symbols**: `<leader>ds`

### Autocompletion

Powered by `nvim-cmp` with multiple sources:
- **LSP completions**: Intelligent suggestions from language servers
- **Snippet expansion**: LuaSnip integration
- **Path completion**: Filesystem path suggestions
- **Buffer completion**: Text from current buffer

#### Completion Keybindings
- `<C-n>` / `<C-p>` - Navigate suggestions
- `<C-y>` - Accept completion
- `<C-Space>` - Trigger completion manually
- `<C-l>` / `<C-h>` - Snippet navigation

### Fuzzy Finding (Telescope)

Telescope provides powerful search capabilities:

| Keybinding | Command | Description |
|------------|---------|-------------|
| `<leader>ff` | `find_files` | Find files (includes hidden, excludes .git) |
| `<leader>fg` | `live_grep` | Search text in all files |
| `<leader>fw` | `grep_string` | Search word under cursor |
| `<leader>fb` | `buffers` | Switch between open buffers |
| `<leader>fh` | `help_tags` | Search Neovim help |
| `<leader>fk` | `keymaps` | Search keybindings |
| `<leader>fs` | `builtin` | Telescope picker selector |
| `<leader>fd` | `diagnostics` | Search LSP diagnostics |
| `<leader>fr` | `resume` | Resume last search |
| `<leader>f.` | `oldfiles` | Recent files |
| `<leader>fn` | `find_files` | Search Neovim config files |
| `<leader>f/` | `live_grep` | Search in open files only |
| `<leader>/` | `current_buffer_fuzzy_find` | Search in current buffer |

### Syntax Highlighting (Treesitter)

Enhanced syntax highlighting and code understanding:
- **Installed parsers**: bash, c, diff, html, lua, luadoc, markdown, markdown_inline, query, vim, vimdoc
- **Auto-install**: New language parsers installed automatically
- **Incremental selection**: Better text objects
- **Folding**: Code folding based on syntax tree

### Git Integration (Gitsigns)

Visual git integration in the editor:
- **Diff indicators**: See added, changed, deleted lines in gutter
- **Hunk navigation**: Jump between changes
- **Git hunks**: Stage, reset, preview changes
- **Blame integration**: See git blame information

### Formatting

Automatic code formatting with `conform.nvim`:
- **Format on save**: Automatically format files when saving
- **Manual formatting**: `<leader>x` to format current buffer
- **LSP fallback**: Use LSP formatting when no dedicated formatter
- **Language-specific**: Different formatters per file type

Configured formatters:
- **Lua**: `stylua` (configured with `.stylua.toml`)

### Theme and UI

- **Colorscheme**: Tokyo Night (night variant)
- **Status line**: Mini.statusline with file info and cursor position
- **Icons**: Nerd Font support for file types and symbols
- **Diagnostics**: Clear error/warning indicators
- **Which-key**: Contextual keybinding hints

## Configuration Structure

### Main Configuration (`init.lua`)

The configuration is organized in logical sections:

1. **Leader keys**: Set to `;` for both leader and localleader
2. **Basic options**: Editor behavior, appearance, and feel
3. **Keymaps**: Essential navigation and utility bindings
4. **Autocommands**: Automatic behaviors (highlight on yank)
5. **Plugin setup**: Lazy.nvim plugin management
6. **Plugin configurations**: Individual plugin settings

### Plugin Management

Uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for:
- **Lazy loading**: Plugins loaded when needed
- **Automatic installation**: Plugins installed on first use
- **Lock file**: Reproducible plugin versions
- **Profile**: Performance monitoring

## Key Plugin Details

### Mason (LSP/Tool Management)

Automatic installation and management of:
- Language servers
- Formatters
- Linters
- Debug adapters

Access with `:Mason` command.

### Which-key

Provides contextual help for keybindings:
- Shows available keys after pressing leader
- Organized by groups (Code, Document, Rename, etc.)
- Self-documenting keybinding system

### Mini.nvim Modules

Collection of small, focused plugins:
- **mini.ai**: Better text objects (around/inside)
- **mini.surround**: Add/delete/replace surroundings
- **mini.statusline**: Lightweight status line

## Customization

### Adding New Plugins

Add to the Lazy.nvim setup in `init.lua`:

```lua
require('lazy').setup({
  -- existing plugins...
  {
    'author/plugin-name',
    config = function()
      -- plugin configuration
    end
  }
})
```

### Adding Language Servers

1. Add to the `servers` table:
```lua
local servers = {
  your_lsp = {
    settings = {
      -- LSP-specific settings
    }
  }
}
```

2. Ensure installation via Mason:
```lua
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'your-tool-name',
})
```

### Custom Keybindings

Add new keybindings following the existing pattern:

```lua
vim.keymap.set('n', '<leader>your_key', function()
  -- your function
end, { desc = 'Your description' })
```

### Appearance Customization

Change colorscheme by modifying the colorscheme plugin:

```lua
{
  'your-theme/nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'your-theme'
  end,
}
```

## Advanced Features

### Health Checks

Run `:checkhealth` to diagnose configuration issues:
- LSP server status
- Plugin health
- External dependencies

### Performance

The configuration includes several performance optimizations:
- Lazy plugin loading
- Efficient treesitter setup
- Minimal startup plugins
- Async operations where possible

Monitor performance with:
- `:Lazy profile` - Plugin load times
- `:help vim.loop` - Async operations

### Debugging

For troubleshooting:
- `:messages` - See all messages
- `:verbose map <key>` - See what a key is mapped to
- `:LspInfo` - LSP server information
- `:Mason` - Tool installation status

## File Types and Workflows

### Lua Development
- Full LSP support with Neovim API
- Automatic formatting with stylua
- Completion for vim APIs

### General Programming
- Generic LSP features for any language
- Treesitter highlighting
- Telescope for code navigation

### Configuration Files
- YAML LSP for configuration editing
- Syntax highlighting for various formats

## Tips and Tricks

1. **Learn Telescope**: Master fuzzy finding to dramatically speed up navigation
2. **Use LSP features**: `gd`, `gr`, and `K` are your best friends
3. **Customize gradually**: Add plugins and configs as you identify needs
4. **Check health regularly**: `:checkhealth` helps catch issues early
5. **Read help**: `:help` for any command or option

## Common Issues

### LSP Not Working
- Check `:LspInfo` for server status
- Verify Mason installation: `:Mason`
- Ensure language server in PATH

### Slow Startup
- Check `:Lazy profile`
- Consider lazy-loading more plugins
- Review startup autocommands

### Missing Features
- Check if related plugin is installed
- Verify keybinding with `:map`
- Look for plugin-specific help: `:help plugin-name`

This configuration provides a solid foundation for modern Neovim development while remaining extensible and customizable.