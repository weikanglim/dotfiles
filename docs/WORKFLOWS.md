# Development Workflows

How to use the dotfiles configuration for productive development workflows.

## Overview

This document describes practical workflows that leverage the integrated toolchain of Neovim, Tmux, and Jujutsu for efficient development.

## Daily Development Workflow

### Starting Your Day

1. **Launch Terminal and Tmux**
   ```bash
   # Start tmux (or it auto-starts with shell integration)
   tmux
   ```

2. **Open Main Project**
   ```bash
   # Use tmux sessionizer to open primary project
   # Press: Ctrl-a f
   # Type project name or browse with arrows
   # Press: Enter to switch/create session
   ```

3. **Set Up Workspace**
   ```bash
   # Split tmux panes as needed
   Ctrl-a "    # Horizontal split
   Ctrl-a %    # Vertical split
   
   # Navigate to different panes
   Ctrl-a h/j/k/l
   ```

4. **Open Editor**
   ```bash
   # Start Neovim in first pane
   nvim .
   
   # Use second pane for terminal commands
   # Use third pane for logs/tests if needed
   ```

### Project Navigation

#### File Discovery with Telescope

```bash
# From Neovim normal mode:
;ff    # Find files in current project
;fg    # Search text across all files
;fb    # Switch between open buffers
;f.    # Open recent files
;fr    # Resume last search
```

#### Project Structure Understanding

```bash
# Use Neovim's built-in file explorer
:Ex

# Or use Telescope to explore
;fn    # Search Neovim config files
;fh    # Search help documentation
;fk    # Search available keybindings
```

### Code Development Cycle

#### Writing Code

1. **Navigate to file**: `;ff` → type filename → Enter
2. **Use LSP features**:
   - `gd` - Go to definition
   - `gr` - Find all references
   - `K` - Show documentation
   - `;ca` - Show code actions
   - `;r` - Rename symbol

3. **Format and save**:
   - `;x` - Format current buffer
   - `:w` - Save file

#### Version Control with JJ

```bash
# Check current status
jj status

# View recent changes
jj log

# Create commit with current changes
jj commit -m "Implement feature X"

# Edit commit message if needed
jj describe -m "Better description"

# View commit history
jj log --graph
```

#### Testing and Debugging

```bash
# Use separate tmux pane for test commands
Ctrl-a j    # Move to bottom pane

# Run tests
npm test    # or pytest, go test, etc.

# Watch test results while coding
# Tests run in separate pane while editing in Neovim
```

## Multi-Project Workflow

### Context Switching

1. **Quick Project Switch**
   ```bash
   # From any tmux session:
   Ctrl-a f
   # Select different project
   # Automatically creates/switches to project session
   ```

2. **Maintain Multiple Contexts**
   ```bash
   # Each project gets its own tmux session
   # Windows and panes persist per project
   # Switch between projects without losing context
   ```

3. **Session Management**
   ```bash
   # List all active sessions
   tmux list-sessions
   
   # Attach to specific session
   tmux attach-session -t project-name
   ```

### Cross-Project Development

#### Working on Related Projects

```bash
# Terminal workflow for related projects:
# Session 1: Main application
# Session 2: Library/dependency
# Session 3: Documentation/tooling

# Quick switching between related work
Ctrl-a f → select session
```

#### Shared Configuration

```bash
# Use consistent tooling across projects
# Neovim LSP adapts to each project
# Tmux sessionizer handles project discovery
# JJ provides consistent VCS interface
```

## Feature Development Workflow

### Starting New Feature

1. **Create Feature Branch/Bookmark**
   ```bash
   # Using JJ bookmarks
   jj bookmark create feature/new-api
   jj commit -m "Start new API feature"
   ```

2. **Set Up Development Environment**
   ```bash
   # Open project with sessionizer
   Ctrl-a f → select project
   
   # Create pane layout
   Ctrl-a "    # Split for terminal
   Ctrl-a %    # Split for logs/tests
   ```

3. **Development Loop**
   - Write code in Neovim
   - Run tests in tmux pane
   - Commit frequently with JJ
   - Use LSP for navigation and refactoring

### Code Review Preparation

#### Clean Up History

```bash
# View current commit history
jj log --graph

# Squash related commits
jj squash --from commit1 --into commit2

# Edit commit messages
jj describe -m "Cleaned up description"

# Reorder commits if needed
jj rebase -d target-parent commit-to-move
```

#### Final Review

```bash
# Use Neovim for final code review
;fg "TODO\|FIXME"    # Search for remaining todos
;fd                  # Check for any diagnostics

# Run full test suite
# (in separate tmux pane)
npm run test:full
```

### Submitting Changes

```bash
# Push to remote (if using Git integration)
jj git push --bookmark feature/new-api

# Or export to Git for platform integration
jj git export
git push origin feature/new-api
```

## Debugging Workflow

### LSP-Based Debugging

```bash
# Use Neovim's LSP features for debugging
;fd    # View all diagnostics
gd     # Go to definition to understand code flow
gr     # Find all usages of problematic function
K      # Show documentation for APIs
```

### Terminal-Based Debugging

```bash
# Use tmux panes for debugging tools
# Pane 1: Neovim editor
# Pane 2: Debug server/REPL
# Pane 3: Log output

# Navigate between panes while debugging
Ctrl-a h/j/k/l
```

### Git/JJ History Debugging

```bash
# Use JJ's powerful history tools
jj log -r 'author("name") & ::@'  # Your commits leading to current
jj log -r '@ ~ main'              # Changes not in main
jj show commit-id                 # View specific commit

# Bisect-like workflow
jj checkout previous-good-commit
# Test, then move forward/backward through history
```

## Writing and Documentation Workflow

### Markdown Editing

```bash
# Use Neovim for markdown with treesitter highlighting
nvim README.md

# Live preview (if configured)
# Use separate browser tab or pane for preview
```

### Org-Mode Integration (with Doom Emacs)

```bash
# Switch to Emacs for org-mode writing
# Keep tmux session for terminal access
emacs ~/personal/notes/project.org
```

### Documentation Maintenance

```bash
# Use Telescope to search across documentation
;fg "TODO"          # Find documentation todos
;ff README          # Quick access to README files
;f/ "deprecated"    # Search in open files
```

## Team Collaboration Workflow

### Shared tmux Sessions

```bash
# For pair programming
tmux new-session -s shared-session
# Share session name with colleague

# Both users can:
# - Navigate independently
# - See real-time changes
# - Use separate panes for different tasks
```

### Code Review Workflow

```bash
# Review others' code
jj git fetch
jj checkout review-branch

# Use Neovim for review
;fg "pattern"      # Search for specific patterns
gd                 # Understand code structure
;fd                # Check for issues
```

### Knowledge Sharing

```bash
# Document workflows in project
nvim docs/development.md

# Share tmux configurations
# Consistent environment across team members
```

## Productivity Tips

### Keyboard Efficiency

```bash
# Master key sequences:
# Tmux: Ctrl-a [command]
# Neovim: ; [command]
# JJ: jj [command]

# Minimize mouse usage
# Learn navigation patterns
# Use fuzzy finding extensively
```

### Session Management

```bash
# Organize sessions by purpose:
# - work-project-1
# - work-project-2  
# - personal-dotfiles
# - learning-rust

# Use descriptive session names
tmux rename-session descriptive-name
```

### Automation

```bash
# Create project startup scripts
#!/bin/bash
# ~/.local/bin/start-project-x
tmux new-session -d -s project-x -c ~/repos/project-x
tmux split-window -t project-x -h
tmux send-keys -t project-x:0.0 'nvim .' Enter
tmux send-keys -t project-x:0.1 'npm run dev' Enter
tmux attach-session -t project-x
```

## Advanced Workflows

### Polyglot Development

```bash
# Different languages in same session
# Pane 1: Frontend (TypeScript/React)
# Pane 2: Backend (Python/Go/Rust)
# Pane 3: Database/tools

# LSP automatically adapts per file type
# Consistent interface across languages
```

### Remote Development

```bash
# SSH into remote server with dotfiles
ssh -t user@server 'tmux attach || tmux new'

# Use same workflows on remote systems
# Consistent environment everywhere
```

### Container Development

```bash
# Develop inside containers with dotfiles
docker run -it -v ~/.dotfiles:/root/.dotfiles ubuntu:22.04
cd /root/.dotfiles && ./install.sh

# Consistent development environment
# Portable across different systems
```

This workflow documentation provides practical guidance for maximizing productivity with the integrated toolchain. The key is to develop muscle memory for the key bindings and understand how the tools complement each other.