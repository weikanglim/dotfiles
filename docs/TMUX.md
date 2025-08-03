# Tmux Configuration

Documentation for the Tmux setup and session management workflow.

## Overview

This Tmux configuration provides a productive terminal multiplexing environment with vim-style navigation, custom session management, and efficient project switching.

## Philosophy

- **Vim-style navigation**: Familiar movement keys for pane switching
- **Project-centric sessions**: Each project gets its own session
- **Quick access**: Fast session switching with fuzzy finding
- **Minimal distractions**: Clean status bar and visual design

## Key Features

### Custom Prefix

Changed from the default `Ctrl-b` to `Ctrl-a` for easier access:
- Closer to home row
- Reduces finger stretching
- Common in many terminal multiplexers

### Vim-Style Navigation

Seamless pane navigation using familiar vim keys:
- `Ctrl-a h` - Move to left pane
- `Ctrl-a j` - Move to bottom pane  
- `Ctrl-a k` - Move to top pane
- `Ctrl-a l` - Move to right pane

### Session Management

Integrated tmux-sessionizer for project workflow:
- Quick session switching
- Automatic project detection
- Fuzzy finding with fzf

### Copy Mode Improvements

Enhanced text selection and copying:
- Vim-style key bindings in copy mode
- Visual selection with `v`
- Copy to system clipboard with `y`

## Configuration Details

### Status Bar

```tmux
set -g status-style 'bg=#333333 fg=#5eacd3'
```
- Dark gray background
- Light blue text
- Minimal visual clutter

### Window Management

```tmux
set -g base-index 1
```
- Windows start at index 1 (instead of 0)
- More intuitive numbering

### Quick Config Reload

```tmux
bind r source-file ~/.tmux.conf
```
- `Ctrl-a r` to reload configuration
- No need to restart tmux for changes

## Key Bindings Reference

| Binding | Action | Description |
|---------|---------|-------------|
| `Ctrl-a` | Prefix | Main prefix key |
| `Ctrl-a Ctrl-a` | Send prefix | Send literal Ctrl-a to terminal |
| `Ctrl-a r` | Reload config | Reload tmux configuration |
| `Ctrl-a ^` | Last window | Switch to previously active window |
| `Ctrl-a h/j/k/l` | Navigate panes | Vim-style pane navigation |
| `Ctrl-a f` | Sessionizer | Open tmux sessionizer |
| `Ctrl-a [` | Copy mode | Enter copy mode |

### Copy Mode Bindings

| Binding | Action | Description |
|---------|---------|-------------|
| `v` | Visual select | Start visual selection |
| `y` | Copy | Copy selection to clipboard |
| `h/j/k/l` | Navigate | Vim-style movement |

## Sessionizer Workflow

The tmux-sessionizer is a powerful script for project management:

### How It Works

1. **Directory scanning**: Searches `~/personal` and `~/repos`
2. **Fuzzy selection**: Uses fzf for quick project finding
3. **Session creation**: Creates/switches to project session
4. **Automatic naming**: Uses directory name as session name

### Usage Patterns

#### From within tmux:
```bash
# Press Ctrl-a f to open sessionizer
# Type to filter projects
# Press Enter to switch to selected project
```

#### From command line:
```bash
# Launch with fuzzy finding
~/.local/bin/tmux-sessionizer

# Launch specific project
~/.local/bin/tmux-sessionizer ~/repos/my-project
```

### Directory Structure

The sessionizer expects projects in:
- `~/personal/` - Personal projects
- `~/repos/` - Work/collaborative projects

Create these directories for optimal workflow:
```bash
mkdir -p ~/personal ~/repos
```

## Session Management Best Practices

### Naming Convention

Sessions are automatically named based on directory:
- `~/repos/my-project` → session name: `my-project`
- `~/personal/dotfiles` → session name: `dotfiles`
- Special characters (like `.`) are converted to `_`

### Workflow Integration

1. **Start of day**: Use sessionizer to open main project
2. **Context switching**: Quickly switch between projects with `Ctrl-a f`
3. **End of day**: Sessions persist, resume where you left off

### Multiple Sessions

- Each project gets its own session
- Sessions run independently
- Switch between them without losing context
- Windows and panes persist per session

## Advanced Usage

### Session Commands

```bash
# List all sessions
tmux list-sessions

# Attach to specific session
tmux attach-session -t session-name

# Kill specific session
tmux kill-session -t session-name

# Rename current session
tmux rename-session new-name
```

### Window Management

```bash
# Create new window
Ctrl-a c

# Rename window
Ctrl-a ,

# Switch to window by number
Ctrl-a [0-9]

# Switch to next/previous window
Ctrl-a n / Ctrl-a p
```

### Pane Management

```bash
# Split horizontally
Ctrl-a "

# Split vertically  
Ctrl-a %

# Close current pane
Ctrl-a x

# Resize panes
Ctrl-a : resize-pane -[UDLR] [amount]
```

## Customization

### Adding New Key Bindings

Add to `.tmux.conf`:
```tmux
bind-key [key] [command]
```

Example - create new binding for vertical split:
```tmux
bind-key v split-window -h
```

### Status Bar Customization

Modify status bar appearance:
```tmux
set -g status-style 'bg=#your-color fg=#your-text-color'
set -g status-left '[#S] '
set -g status-right '%H:%M %d-%b-%y'
```

### Pane Styling

Customize pane borders and highlighting:
```tmux
set -g pane-border-style 'fg=#your-border-color'
set -g pane-active-border-style 'fg=#your-active-color'
```

## Integration with Other Tools

### Neovim Integration

Seamless navigation between tmux panes and nvim splits:
- Use same navigation keys (`h/j/k/l`)
- Consistent workflow between editor and terminal

### Shell Integration

Add to shell configuration for better tmux integration:
```bash
# Auto-start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi
```

### Git Integration

Works well with git workflows:
- Each project session maintains git context
- Separate terminal panes for git commands
- Visual git status in editor and terminal

## Troubleshooting

### Sessionizer Not Working

Check prerequisites:
```bash
# Ensure fzf is installed
which fzf

# Check script permissions
ls -la ~/.local/bin/tmux-sessionizer

# Verify target directories exist
ls -d ~/personal ~/repos
```

### Copy Mode Issues

If copy to clipboard doesn't work:
```bash
# Install xclip (Linux)
sudo apt install xclip

# Or use pbcopy (macOS)
# Modify .tmux.conf to use 'pbcopy' instead of 'xclip'
```

### Key Binding Conflicts

If bindings don't work as expected:
```bash
# Check current bindings
tmux list-keys

# See what a key is bound to
tmux list-keys | grep [key]
```

### Session Restoration

To persist sessions across reboots, consider:
- tmux-resurrect plugin
- tmux-continuum plugin
- Custom session startup scripts

## Tips and Tricks

1. **Learn the prefix**: `Ctrl-a` becomes second nature with practice
2. **Use sessionizer**: Master the fuzzy finding for rapid project switching
3. **Customize gradually**: Add bindings and features as you identify needs
4. **Combine with shell aliases**: Create shortcuts for common tmux commands
5. **Use copy mode**: Efficient text selection and copying without mouse

## Common Workflows

### Daily Development

1. Start tmux with sessionizer: `Ctrl-a f`
2. Select main project
3. Split panes for different tasks (editor, terminal, logs)
4. Switch projects as needed with `Ctrl-a f`

### Multiple Projects

1. Keep separate sessions for different projects
2. Use descriptive session names
3. Switch context quickly with sessionizer
4. Resume work exactly where you left off

### Pair Programming

1. Share tmux session with colleague
2. Both users can navigate independently
3. Real-time collaboration in same environment
4. Preserve session state for continued work

This tmux configuration provides a solid foundation for productive terminal-based development workflows.