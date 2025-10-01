# GitHub PR Review in Neovim - Setup & Usage Guide

## 🚀 Setup Instructions

### 1. First-Time Setup

1. **Restart your terminal** to ensure GitHub CLI is in your PATH
2. **Authenticate with GitHub CLI**:
   ```powershell
   gh auth login
   ```
   - Choose "GitHub.com" 
   - Select "HTTPS" or "SSH" (your preference)
   - Authenticate via web browser
   - Give it appropriate scopes for repo access

3. **Test GitHub CLI**:
   ```powershell
   gh repo list
   ```

4. **Restart Neovim** to load the new plugins:
   ```powershell
   nvim
   ```

### 2. Plugin Installation

The following plugins have been added to your configuration:
- **octo.nvim**: Main GitHub integration plugin
- **telescope-github.nvim**: GitHub-specific telescope pickers  
- **git-worktree.nvim**: Enhanced git worktree support for PR branches

## 🎯 Key Features

### GitHub Pull Request Management
- View PRs directly in Neovim
- Review code changes with inline comments
- Approve, request changes, or comment on PRs
- Checkout PR branches for testing
- View PR checks and CI status

### Code Review Workflow
- Start reviews from within Neovim
- Add line-by-line comments and suggestions
- View and respond to review comments
- Submit reviews (approve/request changes/comment)

### Issue Management
- List and view GitHub issues
- Create new issues from Neovim
- Add comments and manage issue lifecycle

## ⌨️ Key Bindings

### Main GitHub Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>go` | Open Octo | Open Octo main interface |

### Pull Requests (`<leader>gp`)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gpl` | List PRs | Show all PRs in current repo |
| `<leader>gpc` | Create PR | Create a new pull request |
| `<leader>gpr` | PR Checks | View PR check status |
| `<leader>gpd` | PR Diff | Show PR diff view |
| `<leader>gpm` | Merge PR | Merge the current PR |
| `<leader>gps` | Checkout PR | Checkout PR branch locally |

### Issues (`<leader>gi`)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gil` | List Issues | Show all issues in current repo |
| `<leader>gic` | Create Issue | Create a new issue |

### Code Review (`<leader>gr`)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>grl` | Start Review | Begin reviewing a PR |
| `<leader>grs` | Submit Review | Submit your review |
| `<leader>grc` | Review Comments | View review comments |
| `<leader>gra` | Resume Review | Resume an in-progress review |

### GitHub Search via Telescope (`<leader>gh`)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>ghp` | Search PRs | Search pull requests via telescope |
| `<leader>ghi` | Search Issues | Search issues via telescope |
| `<leader>ghr` | GitHub Actions | View GitHub Actions runs |
| `<leader>ghg` | GitHub Gists | Browse your gists |

### Git Worktree (`<leader>gw`)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gwc` | Create Worktree | Create new git worktree for PR |
| `<leader>gws` | Switch Worktree | Switch between worktrees |

### Enhanced Diffview for PR Review
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gpr` | PR Diff vs Main | Compare current branch vs main/master |
| `<leader>gpc` | Compare Previous | Compare with previous commit |
| `<leader>gpf` | PR File History | Show file history for PR |

## 🔄 Typical PR Review Workflow

### 1. Reviewing a Pull Request

```vim
" Step 1: List all PRs
<leader>gpl

" Step 2: Open a specific PR (from the list or by number)
:Octo pr view 123

" Step 3: Start a review
<leader>grl

" Step 4: View the diff
<leader>gpd
" or use enhanced diffview
<leader>gpr

" Step 5: Add comments on specific lines
" Navigate to a line and press <space>ca (add comment)

" Step 6: Submit your review
<leader>grs
" Choose: Approve (C-a), Comment (C-m), or Request Changes (C-r)
```

### 2. Working on a PR Locally

```vim
" Step 1: Checkout the PR branch
<leader>gps

" Step 2: Make your changes in Neovim

" Step 3: View changes with diffview
<leader>gv

" Step 4: Commit and push (using LazyGit)
<leader>gg
```

### 3. Creating a New PR

```vim
" Step 1: Make sure you're on a feature branch with commits
" Step 2: Create PR from Neovim
<leader>gpc

" This will open a buffer where you can:
" - Set PR title and description
" - Add reviewers
" - Set labels and assignees
" - Link issues
```

## 🎛️ In-Review Keybindings

When you're in an Octo buffer (viewing a PR or issue), these additional keybindings are available:

### PR/Issue Navigation
- `}c` / `{c` - Next/previous comment
- `]q` / `[q` - Next/previous changed file
- `gf` - Go to file
- `<C-r>` - Reload PR/issue
- `<C-b>` - Open in browser

### Actions
- `<space>ca` - Add comment
- `<space>sa` - Add suggestion (in review mode)
- `<space>cd` - Delete comment
- `<space>po` - Checkout PR
- `<space>pm` - Merge PR
- `<space>va` - Add reviewer
- `<space>aa` - Add assignee
- `<space>la` - Add label

### Reactions
- `<space>r+` - 👍 thumbs up
- `<space>r-` - 👎 thumbs down  
- `<space>rh` - ❤️ heart
- `<space>re` - 👀 eyes
- `<space>rr` - 🚀 rocket
- `<space>rl` - 😄 laugh

## 🛠️ Troubleshooting

### GitHub CLI Not Found
If you get "command not found" errors:
1. Restart your terminal
2. Verify installation: `gh --version`
3. Re-authenticate: `gh auth login`

### Authentication Issues
```powershell
# Check auth status
gh auth status

# Re-login if needed
gh auth login

# Test access to a repository
gh repo view owner/repo
```

### Plugin Not Loading
1. Restart Neovim
2. Check for plugin errors: `:checkhealth`
3. Update plugins: `:Lazy sync`

## 🎨 Customization

The GitHub integration is configured with your Nightfox theme colors. You can customize the appearance by editing `lua/plugins/github.lua` and adjusting the highlight groups in the config section.

## 📚 Additional Resources

- [octo.nvim Documentation](https://github.com/pwntester/octo.nvim)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Git Worktree Tutorial](https://git-scm.com/docs/git-worktree)

Enjoy your enhanced GitHub workflow in Neovim! 🎉