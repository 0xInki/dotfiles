# Config Reference

Brief overview of what each config does and the choices made.

---

## ZSH (`zsh/.zshrc`)

Built on top of **Oh My Zsh** with the following plugins:

| Plugin | Purpose |
|--------|---------|
| `git` | Git aliases and helpers |
| `vi-mode` | Vim-style navigation in the terminal |
| `npm` | npm aliases |
| `jump` | Navigate to directories with `j <name>` |
| `tmux` | tmux integration |

### Prompt

Simple custom prompt: `[folder] 火`
- Current directory in orange
- RPROMPT shows git status (branch, staged, unstaged)

### Notable aliases

| Alias | Command |
|-------|---------|
| `v`, `vi`, `vim` | `nvim` |
| `qq` | `exit` |
| `ezsh` / `szsh` | Edit / reload `.zshrc` |
| `etmux` / `stmux` | Edit / reload `.tmux.conf` |
| `evim` | Edit `nvim/init.lua` |
| `t` | `tmux` |
| `ta` | `tmux attach` |
| `tm <name>` | Create or attach to a tmux session |
| `tmdev` | Create a dev session with 3 panes |
| `dev` | `npm run dev` (with fallback to `start-dev`) |

### History

| Option | Effect |
|--------|--------|
| `HIST_IGNORE_DUPS` | Doesn't save a command if it's identical to the previous one |
| `HIST_IGNORE_SPACE` | Commands prefixed with a space are not saved (useful for secrets) |
| `SHARE_HISTORY` | All open terminals share the same history in real time |

### fzf shell integration

Sourced from the Homebrew fzf installation. Enables three keybindings:

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy search through command history |
| `Ctrl+T` | Fuzzy file picker — inserts selected path into the current command |
| `Alt+C` | Fuzzy directory jump — `cd` into the selected directory |

### Other

- **thefuck** — corrects the last mistyped command with `fuck` (lazy-loaded — only initializes on first use)
- **NVM** — Node version management via Homebrew

---

## Tmux (`tmux/.tmux.conf`)

### General settings

- Prefix remapped to `Ctrl+a` (more ergonomic than `Ctrl+b`)
- Mouse enabled
- Windows and panes start at index `1`
- 10,000 line scrollback history
- Automatic window renumbering when one is closed

### Theme

**Gruvbox Material Dark (Medium)** — consistent with Neovim and Ghostty.

### Key bindings

| Shortcut | Action |
|----------|--------|
| `Prefix =` | Split pane horizontally |
| `Prefix -` | Split pane vertically |
| `Prefix h/j/k/l` | Navigate between panes (vim-style) |
| `Prefix H/J/K/L` | Resize panes |
| `Prefix c` | New window in current directory |
| `Prefix q` | Kill session |
| `Prefix S` | Synchronize panes (type in all at once) |
| `Prefix f` | Fuzzy directory picker — `cd` into the selected directory |

### Copy mode

- Vim-style keybindings (`v` to select, `y` to copy)
- Copies directly to macOS clipboard via `pbcopy`

### Plugins (TPM)

| Plugin | Purpose |
|--------|---------|
| `tmux-sensible` | Sensible defaults |
| `tmux-resurrect` | Save and restore sessions |
| `vim-tmux-navigator` | Unified navigation between tmux panes and nvim splits |
| `tmux-yank` | Enhanced clipboard integration |
| `tmux-copycat` | Advanced search in scrollback history |
| `tmux-open` | Open files and URLs directly from the terminal |
| `tmux-fzf` | Fuzzy finder inside tmux |

---

## Ghostty (`ghostty/config`)

Minimal configuration — colors only.

**Gruvbox Material Dark (Medium)**, with all 16 ANSI colors defined manually to ensure exact consistency with Neovim and tmux.

---

## Neovim (`nvim/`)

Based on **kickstart.nvim** with customizations.

### Base plugins (kickstart)

| Plugin | Purpose |
|--------|---------|
| `lazy.nvim` | Plugin manager |
| `telescope.nvim` | Fuzzy finder (files, grep, buffers) |
| `nvim-treesitter` | Advanced syntax highlighting |
| `nvim-lspconfig` | Language Server Protocol |
| `mason.nvim` | LSP and tool installer |
| `blink.cmp` | Autocomplete |
| `LuaSnip` | Snippets |
| `gitsigns.nvim` | Git indicators in the gutter |
| `which-key.nvim` | Available keybindings popup |
| `todo-comments.nvim` | Highlight TODO/FIXME in comments |
| `mini.nvim` | Collection of utilities (statusline, surround, etc.) |
| `conform.nvim` | Auto formatting |
| `gruvbox-material` | Color theme |

### Custom plugins

| Plugin | Purpose |
|--------|---------|
| `copilot.vim` | GitHub Copilot — AI code suggestions |
| `arrow.nvim` | Quick file bookmarks (`;` global, `m` per buffer) |
| `code-bridge.nvim` | Integration with external code tools |

### General settings

- Leader key: `Space`
- Relative line numbers enabled
- Clipboard synced with the system
- Persistent undo (survives closing the file)
- Case-insensitive search (unless uppercase letters are used)
- `scrolloff = 10` — keeps 10 lines of context when scrolling
