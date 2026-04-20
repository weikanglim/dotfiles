# Jujutsu (JJ) Configuration

Documentation for the Jujutsu version control setup in this dotfiles repository.

## Overview

[Jujutsu (JJ)](https://github.com/martinvonz/jj) is a modern version control system that provides a more intuitive interface than Git while maintaining Git compatibility. This configuration sets up JJ for productive development workflows.

## Philosophy

- **Modern version control**: Better UX than traditional Git
- **Non-destructive**: Operations are safe and reversible
- **Workflow-focused**: Optimized for common development patterns
- **Git-compatible**: Works with existing Git repositories

## What is Jujutsu?

Jujutsu is a version control system that aims to solve many of Git's usability issues:

### Key Advantages over Git

1. **No staging area**: Changes are tracked automatically
2. **Safe operations**: Almost everything is reversible
3. **Better conflict resolution**: More intuitive merge conflict handling
4. **Automatic local branching**: Every commit gets a unique identifier
5. **Cleaner history**: Built-in support for clean commit history

### Git Compatibility

- Can work with Git remotes
- Converts Git repositories seamlessly
- Supports Git hosting platforms (GitHub, GitLab, etc.)
- Can coexist with Git workflows

## Configuration Details

### Default Command

```toml
[ui]
default-command = "log"
```

When you run `jj` without arguments, it shows the commit log instead of help. This provides immediate visibility into your repository state.

### User Configuration

```toml
[user]
name = "Wei Lim"
email = "weikanglim@gmail.com"
```

Sets up authorship information for commits.

### Custom Aliases

```toml
[aliases]
tug = ["bookmark", "move", "--from", "heads(::@- & bookmarks())", "--to", "@-"]
```

The `tug` alias moves bookmarks from descendant commits to the parent commit, useful for bookmark management workflows.

## Core Concepts

### Working Copy (`@`)

- The `@` symbol represents your current working copy
- Unlike Git's staging area, changes are automatically tracked
- You can always see what's changed with `jj diff`

### Change IDs

Every change gets a unique identifier:
- Stable across rebases and amendments
- Makes it easy to refer to specific changes
- Enables safe history editing

### Bookmarks (Branches)

JJ uses "bookmarks" instead of Git branches:
- More explicit about what they represent
- Can be moved easily between commits
- Support for local and remote bookmarks

## Basic Workflow

### Starting with JJ

```bash
# Initialize new repository
jj init

# Or start in existing Git repo
jj init --git-repo .

# Check status
jj status

# View commit history
jj log
```

### Making Changes

```bash
# Edit files (no need to stage)
echo "Hello World" > file.txt

# See what changed
jj diff

# Create a commit
jj commit -m "Add hello world"

# Or describe the current change
jj describe -m "Add hello world"
```

### Working with History

```bash
# View log with graph
jj log --graph

# Edit a previous commit
jj edit [change-id]

# Squash changes into previous commit
jj squash

# Split a commit
jj split [change-id]
```

### Bookmarks (Branches)

```bash
# Create bookmark
jj bookmark create feature-name

# Move bookmark to current change
jj bookmark move feature-name

# List bookmarks
jj bookmark list

# Use the tug alias to move bookmarks
jj tug
```

## Integration with Git Workflows

### Working with Git Remotes

```bash
# Add Git remote
jj git remote add origin https://github.com/user/repo.git

# Fetch from remote
jj git fetch

# Push changes
jj git push
```

### Converting from Git

```bash
# In existing Git repository
jj init --git-repo .

# JJ now manages the repository
# Git commands still work if needed
```

### Interoperability

- JJ repositories contain a `.jj` directory alongside `.git`
- You can use both JJ and Git commands
- Changes made with Git are visible to JJ and vice versa

## Advanced Usage

### Revsets (Powerful Queries)

JJ uses "revsets" to specify commits:

```bash
# All commits
jj log -r all()

# Commits in current branch
jj log -r ::@

# Commits not pushed to main
jj log -r ::@ ~ ::main

# Commits by author
jj log -r 'author("wei")'

# Recent commits
jj log -r '@-5:'
```

### Conflict Resolution

JJ has superior conflict resolution:

```bash
# Conflicts are shown as special files
jj status

# Resolve conflicts by editing
$EDITOR conflicted-file

# Mark as resolved
jj resolve

# Continue operation
jj commit -m "Resolve conflicts"
```

### History Editing

Safe history editing is a JJ strength:

```bash
# Amend current change
jj commit --amend

# Edit any change in history
jj edit [change-id]

# Rebase changes
jj rebase -d [destination]

# Undo operations
jj undo

# Show operation history
jj op log
```

## Daily Workflows

### Feature Development

```bash
# Start new feature
jj bookmark create feature-xyz
jj commit -m "Start feature xyz"

# Make changes
echo "feature code" > feature.py
jj commit -m "Implement feature xyz"

# Push to remote
jj git push --bookmark feature-xyz
```

### Code Review Workflow

```bash
# Address review feedback
jj edit [commit-with-feedback]
# Make changes
jj commit -m "Address review feedback"

# Squash review fixes
jj squash --into [original-commit]

# Force push updates
jj git push --bookmark feature-xyz --force
```

### Maintaining Clean History

```bash
# View current history
jj log --graph

# Reorder commits
jj rebase -d [new-parent] [commit-to-move]

# Squash related commits
jj squash --from [commit1] --into [commit2]

# Split large commits
jj split [large-commit]
```

## Configuration Customization

### UI Preferences

```toml
[ui]
default-command = "status"  # Or "log", "summary"
pager = "less -FRX"
editor = "nvim"
```

### Diff and Log Settings

```toml
[ui]
diff-editor = "nvim -d"
log-synthetic-elided-nodes = true
log-word-wrap = true
```

### Git Integration

```toml
[git]
push-bookmark-prefix = "refs/heads/"
auto-local-bookmark = true
```

### Custom Aliases

Add your own aliases:

```toml
[aliases]
# Quick shortcuts
st = ["status"]
co = ["checkout"]
br = ["bookmark", "list"]

# Complex workflows
pushf = ["git", "push", "--force-with-lease"]
sync = ["git", "fetch", "--all-remotes"]
```

## Migration from Git

### For Git Users

Key differences to understand:

1. **No staging area**: `jj commit` creates a new change from working copy
2. **Everything is local**: Operations are fast and safe
3. **Change IDs**: More stable than Git SHAs
4. **Automatic branches**: Every commit is on a branch

### Common Git Commands in JJ

| Git Command | JJ Equivalent | Notes |
|-------------|---------------|--------|
| `git add .` | (automatic) | Changes tracked automatically |
| `git commit` | `jj commit` | Creates new change |
| `git log` | `jj log` | Shows commit history |
| `git status` | `jj status` | Shows working copy state |
| `git checkout` | `jj checkout` | Switch to different change |
| `git branch` | `jj bookmark` | Manage bookmarks |
| `git merge` | `jj merge` | Merge changes |
| `git rebase` | `jj rebase` | Rebase changes |
| `git reset` | `jj undo` | Undo operations |

### Migration Strategy

1. **Start with existing repo**: `jj init --git-repo .`
2. **Learn gradually**: Use JJ for new work, Git for existing workflows
3. **Explore revsets**: Learn powerful query language
4. **Embrace safety**: Use JJ's safe operations to build confidence

## Tips and Best Practices

### Learning JJ

1. **Start small**: Use basic commands first
2. **Leverage safety**: Experiment freely, operations are reversible
3. **Learn revsets**: Powerful for complex queries
4. **Use bookmarks**: Better organization than Git branches
5. **Read logs**: Default command shows repository state

### Productivity Tips

1. **Use aliases**: Create shortcuts for common operations
2. **Learn key revsets**: `@`, `::@`, `@-`, etc.
3. **Embrace history editing**: Clean up commits before sharing
4. **Use `jj undo`**: Fearlessly try operations
5. **Combine with shell**: Create functions for complex workflows

### Integration

1. **IDE support**: Configure editor integration
2. **Shell completion**: Enable command completion
3. **Tmux sessions**: One session per project
4. **Combine with other tools**: Works with existing development tools

## Troubleshooting

### Common Issues

**JJ not found:**
```bash
# Install JJ
cargo install jj-cli
# Or use package manager
```

**Git conflicts:**
```bash
# If both Git and JJ modify repository
jj status
jj git import  # Import Git changes
```

**Bookmark issues:**
```bash
# Reset bookmark to specific commit
jj bookmark move bookmark-name -r [change-id]
```

### Getting Help

```bash
# General help
jj help

# Command-specific help
jj help [command]

# Tutorial
jj tutorial
```

## Resources

- [Jujutsu Documentation](https://github.com/martinvonz/jj/blob/main/docs/README.md)
- [JJ Tutorial](https://github.com/martinvonz/jj/blob/main/docs/tutorial.md)
- [Git Comparison](https://github.com/martinvonz/jj/blob/main/docs/git-comparison.md)

This JJ configuration provides a modern, efficient version control workflow that enhances productivity while maintaining Git compatibility.