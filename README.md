# oh-my-zsh-gitworktree

> A fast and safe Git Worktree management plugin for oh-my-zsh

English | [简体中文](README.zh-CN.md)

## Features

- ✨ **Quick Creation** - Create a new worktree with a single command
- 🛡️ **Main Repository Protection** - Prevents accidental deletion of the main repository
- 🔍 **Smart Detection** - Automatically detects worktree directories and validates operations
- 🎨 **Friendly Prompts** - Beautiful emoji-enhanced feedback messages
- ⚡ **Lightweight** - No dependencies (except optional `gum` for confirmations)

## Installation

### Method 1: One-line Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/foolgry/oh-my-zsh-gitworktree/main/install.sh | bash
```

### Method 2: Manual Install

1. Clone the repository to oh-my-zsh custom plugins directory:

```bash
git clone https://github.com/foolgry/oh-my-zsh-gitworktree.git \
  ~/.oh-my-zsh/custom/plugins/gitworktree
```

2. Add `gitworktree` to your plugins in `~/.zshrc`:

```zsh
plugins=(... gitworktree)
```

3. Reload your shell configuration:

```bash
source ~/.zshrc
```

## Usage

### `gwa` - Git Worktree Add

Create a new worktree with the specified branch name:

```bash
gwa <branch-name>
```

**Example:**

```bash
# In your main repository (e.g., ~/project/myapp)
gwa feature/new-ui

# Creates: ../myapp-feature/new-ui
# And automatically switches to that directory
```

**Directory Naming Convention:**

```
<original-name>-<branch-name>
```

Examples:
- `myapp` → `myapp-feature/login`
- `backend-api` → `backend-api-fix-bug`

### `gwd` - Git Worktree Delete

Remove the current worktree and its branch:

```bash
gwd
```

**Safety Features:**

- 🔒 **Main Repository Protection** - Cannot run in main repository
- ✅ **Confirmation Prompt** - Uses `gum` for interactive confirmation
- ✅ **Validation** - Checks if current directory is a valid worktree

**Requirements:**

- [gum](https://github.com/charmbracelet/gum) for interactive confirmation prompts:

```bash
brew install gum
```

## Examples

### Workflow Example

```bash
# 1. In your main repository
cd ~/project/myapp

# 2. Create a new worktree
gwa feature/user-auth

# You are now in: ../myapp-feature/user-auth

# 3. Do your work...
git add .
git commit -m "Add user authentication"

# 4. When done, clean up
gwd

# Worktree and branch are deleted, you're back in main repository
```

### Multiple Worktrees

```bash
# Main repository
cd ~/project/myapp

# Create multiple worktrees for different tasks
gwa feature/payment     # → ../myapp-feature/payment
gwa fix/bug-123         # → ../myapp-fix/bug-123
gwa refactor/database   # → ../myapp-refactor/database

# Each worktree is isolated and can have its own:
# - Branch
# - Uncommitted changes
# - Node modules / dependencies
# - Environment configuration
```

## Commands Reference

| Command | Description | Usage |
|---------|-------------|-------|
| `gwa` | Add (create) a new worktree | `gwa <branch-name>` |
| `gwd` | Delete current worktree | `gwd` |

## How It Works

### Directory Structure

```
project/
├── myapp/              ← Main repository
├── myapp-feature-a/    ← Worktree for feature-a
├── myapp-fix-bug-123/  ← Worktree for bug fix
└── myapp-refactor-db/  ← Worktree for refactor
```

### Safety Mechanisms

1. **Main Repository Detection** - Uses `git rev-parse --git-common-dir` to identify the main repository
2. **Worktree Validation** - Checks directory naming convention (must contain `-`)
3. **Confirmation Required** - Prompts before destructive operations

## Requirements

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- Git 2.19+ (for worktree support)
- [gum](https://github.com/charmbracelet/gum) (optional, for `gwd` confirmations)

## License

MIT License - feel free to use and modify as needed.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

This plugin is adapted from [vikingmute's Git Worktree management script](https://gist.github.com/vikingmute/0c641db6a834a7a6bee7bd677323bc97), originally shared in [this post](https://x.com/vikingmute/status/2006004791424733525).

The original script has been refactored into an oh-my-zsh plugin format for easier installation and use.
