# ~/.zshrc - Zsh Configuration File of Michael-Matta1 @ https://github.com/Michael-Matta1/dev-dotfiles

# ============================================================================
# 1. PROFILING (uncomment to debug slow startup)
# ============================================================================
# Usage: Run `zprofrc` to launch zsh with profiling enabled
# [[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
# alias zprofrc="ZPROFRC=1 zsh"

# ============================================================================
# 2. INSTANT PROMPT - Must stay close to the top of ~/.zshrc
# ============================================================================
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# 3. OH-MY-ZSH CONFIGURATION (must be before sourcing oh-my-zsh)
# ============================================================================
# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# ============================================================================
# 4. ZSH OPTIONS
# ============================================================================
# -- Directory Navigation --
setopt AUTO_CD                 # Change directories without 'cd'
setopt AUTO_PUSHD              # Push directory to stack on cd
setopt PUSHD_IGNORE_DUPS       # Don't push duplicate directories
setopt PUSHD_SILENT            # Don't print directory stack after pushd/popd

# -- Globbing & Expansion --
setopt EXTENDED_GLOB           # Extended globbing (#, ~, ^)
setopt NO_CASE_GLOB            # Case-insensitive globbing

# -- Job Control --
setopt NO_HUP                  # Don't kill jobs on shell exit
setopt NO_BG_NICE              # Don't nice background jobs
setopt LOCAL_OPTIONS           # Allow functions to have local options
setopt LOCAL_TRAPS             # Allow functions to have local traps

# -- Completion Behavior --
# Core completion options (fzf-tab plugin provides enhanced menu display)
setopt COMPLETE_IN_WORD        # Complete from both ends of a word
setopt COMPLETE_ALIASES        # Enable alias completion
setopt AUTO_PARAM_SLASH        # Auto-add slash after directory completion
setopt AUTO_LIST               # Automatically list choices on ambiguous completion
setopt AUTO_MENU               # Show completion menu on successive tab press

# -- Input/Output --
setopt CORRECT                 # Suggest corrections for mistyped commands
setopt INTERACTIVE_COMMENTS    # Allow comments in interactive shells
setopt NO_FLOW_CONTROL         # Disable Ctrl+S/Ctrl+Q flow control (frees up keys)
setopt NO_BEEP                 # Don't beep on errors
setopt GLOB_DOTS               # Include dotfiles in glob patterns without explicit dot

# ============================================================================
# 5. HISTORY CONFIGURATION
# ============================================================================
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000

# -- History Options --
setopt APPEND_HISTORY          # Append to history file
setopt INC_APPEND_HISTORY      # Add commands immediately (not just on exit)
setopt SHARE_HISTORY           # Share history between all sessions
setopt EXTENDED_HISTORY        # Save timestamp and duration

# -- Duplicate Handling --
setopt HIST_IGNORE_ALL_DUPS    # Don't save duplicate commands
setopt HIST_FIND_NO_DUPS       # Don't show duplicates when searching
setopt HIST_SAVE_NO_DUPS       # Don't write duplicates to the history file
setopt HIST_IGNORE_DUPS        # Ignore consecutive duplicates
setopt HIST_EXPIRE_DUPS_FIRST  # Delete duplicates first when HISTFILE is full

# -- Privacy & Cleanup --
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space (for sensitive commands)
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands
setopt HIST_VERIFY             # Show expanded history before executing

# ============================================================================
# 6. COMPLETIONS (fpath must be set before loading plugins)
# ============================================================================
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# ============================================================================
# 7. PLUGINS (order matters: syntax-highlighting must be LAST)
# ============================================================================
# zsh-autosuggestions and zsh-syntax-highlighting are loaded via system packages in Section 12
# to provide explicit control over initialization order and prevent double-loading.

# FZF integration is configured manually in Section 12 for precise control over key bindings
# and completion behavior, rather than using the oh-my-zsh fzf plugin.

# Shell history is managed by atuin. Alternative: zsh-history-substring-search can be used
# by adding it to the plugins array and removing atuin initialization in Section 12.
plugins=(
  zsh-edit-select  # https://github.com/Michael-Matta1/zsh-edit-select
  git
  zoxide
  zsh-completions
  fzf-tab              # fzf-tab works without the fzf plugin
  sudo
  colored-man-pages
  command-not-found
  extract
  copypath
  copyfile
  copybuffer
)

# ============================================================================
# 8. SOURCE OH-MY-ZSH
# ============================================================================
source $ZSH/oh-my-zsh.sh

# ============================================================================
# 9. ENVIRONMENT VARIABLES & PATH
# ============================================================================
# -- Editor --
export EDITOR='code'
export VISUAL="${EDITOR}"

# -- PATH Configuration --
# Entries are processed in order of precedence (earlier entries override later ones)
# Conditional checks prevent errors from non-existent directories

# User binaries (highest priority)
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Development tools
[[ -d "$HOME/.local/kitty.app/bin" ]] && export PATH="$HOME/.local/kitty.app/bin:$PATH"
[[ -d "/usr/local/node-22/bin" ]] && export PATH="/usr/local/node-22/bin:$PATH"

# Go
[[ -d "/usr/local/go/bin" ]] && export PATH="/usr/local/go/bin:$PATH"
[[ -d "$HOME/go/bin" ]] && export PATH="$HOME/go/bin:$PATH"

# LM Studio CLI
[[ -d "$HOME/.lmstudio/bin" ]] && export PATH="$PATH:$HOME/.lmstudio/bin"

# Load additional environment (if exists)
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# -- Zoxide Configuration --
export _ZO_FZF_OPTS="--preview 'eza -la --color=always {2..} | head -100'"

# -- FZF Configuration (must be before fzf sourcing) --
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ============================================================================
# 10. COMPLETION STYLES (after oh-my-zsh is loaded)
# ============================================================================
# -- Caching --
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# -- Matching --
# Case-insensitive matching with partial word completion support
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# -- Display --
# Use LS_COLORS for consistent file type coloring in completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Format completion group descriptions (optimized for fzf-tab display)
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# -- Completion Behavior --
zstyle ':completion:*' completer _expand _complete _files _correct _approximate
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' menu no  # Disable default menu (using fzf-tab instead)

# -- Git-specific --
zstyle ':completion:*:git-checkout:*' sort false

# ============================================================================
# 11. KEY BINDINGS
# ============================================================================
# -- Custom Widgets --
# Copy selected text or whole line with Ctrl+/
x-copy-selection () {
  if [[ $MARK -ne $CURSOR ]]; then
    local start=$(( MARK < CURSOR ? MARK : CURSOR ))
    local length=$(( MARK > CURSOR ? MARK - CURSOR : CURSOR - MARK ))
    local selected="${BUFFER:$start:$length}"
    print -rn "$selected" | xclip -selection clipboard
  fi
}
zle -N x-copy-selection
bindkey '^_' x-copy-selection

# -- Word Navigation --
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^[[1;5D' backward-word     # Ctrl+Left
bindkey '^H' backward-kill-word     # Ctrl+Backspace
# Delete key word-deletion is configured via zsh-edit-select plugin

# -- Autosuggestions --
bindkey '^ ' forward-word           # Accept word-by-word with Ctrl+Space
bindkey "^[\[13;2u" autosuggest-execute  # Accept AND Execute with Shift+Enter (rely on kitty.conf)

# -- Shift-Tab for Reverse Completion --
bindkey '^[[Z' reverse-menu-complete

# -- Quick Directory Jumping --
bindkey -s '^[z' 'zi\n'        # Alt+Z for interactive zoxide

# -- Clear Screen and Scrollback --
bindkey '^L' clear-screen      # Ctrl+L clears screen (default, but explicit)


# ============================================================================
# 12. EXTERNAL SOURCES & TOOLS
# ============================================================================
# -- Autosuggestions (system-wide) --
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# -- Syntax Highlighting (system-wide) --
# Fix slow pasting with zsh-syntax-highlighting
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -- Powerlevel10k Theme Configuration --
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -- thefuck (command correction) --
# Lazy-loaded to avoid ~300-500ms startup delay from eval on every shell initialization
fuck() {
  unfunction fuck  # Remove this lazy-load wrapper
  eval $(thefuck --alias)  # Actually initialize thefuck
  fuck "$@"  # Run the command
}

# -- Atuin (better shell history) --
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# -- FZF Keybindings and Completions --
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Rebind fzf file search from Ctrl+T to Ctrl+F
bindkey -r '^T'
bindkey '^F' fzf-file-widget

# Alternative: if fzf was installed via git
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -- Starship (alternative prompt - uncomment to use instead of p10k) --
# eval "$(starship init zsh)"

# ============================================================================
# 13. ALIASES
# ============================================================================
# -- Quick Navigation --
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias open='xdg-open .'

# -- Directory Stack Navigation --
# Show numbered directory history with 'd', then use number aliases (1-9) to jump
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# -- Better Defaults with Safety --
alias cp='cp -iv'              # Interactive, verbose
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -iv'
alias mkdir='mkdir -pv'        # Make parent dirs as needed

# -- Editor --
alias scode='sudo -E code --no-sandbox --user-data-dir=/root/.vscode-root'

# -- Quick Config Edits --
alias zshconfig='${EDITOR:-nano} ~/.zshrc'
alias zrc='source ~/.zshrc'
alias pyva='source .venv/bin/activate'

# -- Modern CLI Tool Replacements --
alias cat='batcat'             # bat binary is named batcat on Ubuntu/Debian
alias bat='batcat'
alias ls='eza -la'             # modern ls
alias ll='eza -la'             # explicit long listing
alias la='eza -la'             # list all
alias lt='eza -la --tree --level=2'  # tree view
alias fd='fdfind'              # Use fd as alias instead of replacing find
alias grep='rg'                # ripgrep
alias top='htop'               # better top
alias du='dust'                # better du
# Note: find is not aliased to fdfind to preserve compatibility with scripts expecting GNU find

# -- Git Shortcuts --
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gaa='git add .'
alias gpl='git pull'
alias gtree='git log --graph --oneline --decorate --all'
alias gco='git checkout'       # Checkout shortcut
alias gb='git branch'          # Branch shortcut
alias gst='git stash'          # Stash shortcut
alias gstp='git stash pop'     # Stash pop shortcut
alias gcp='git cherry-pick'    # Cherry pick
alias grb='git rebase'         # Rebase
alias gf='git fetch --all --prune'  # Fetch all with prune

# -- System (Pop!_OS / Ubuntu specific) --
alias update='sudo apt update && sudo apt upgrade'
alias cleanup='sudo apt autoremove && sudo apt autoclean'
alias installed='apt list --installed'
alias search='apt search'

# -- Useful Shortcuts --
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
alias restart="shutdown -r 0"
alias path='echo $PATH | tr ":" "\n"'

# -- Global Aliases (can be used anywhere in command) --
alias -g H='| head'           # First part of output
alias -g T='| tail'           # Last part of output
alias -g G='| grep'           # Search in output
alias -g L='| less'           # Page through output
alias -g LL='2>&1 | less'     # Redirect stderr to stdout and page
alias -g NUL='> /dev/null 2>&1'  # Silence output completely

# -- Quick File Operations --
alias lc='command find . -type f | wc -l'    # Count files (use command to bypass aliases)
alias ld='eza -laD'            # List only directories

# -- Date/Time Utilities --
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias unixepoch="date +%s"
alias epoch2date='_epoch2date() { date -d @"$1" "+%Y-%m-%d %H:%M:%S"; }; _epoch2date'  # Convert epoch to human

# Download (uncomment if using aria2c)
# alias wget='aria2c'
# alias curl='aria2c'

# ============================================================================
# 14. CUSTOM FUNCTIONS
# ============================================================================
# -- Archive Listing --
ls-archive() {
  if [[ ! -f "$1" ]]; then echo "File not found"; return 1; fi
  case "${1##*.}" in
    zip) unzip -l "$1" ;;
    rar) unrar l "$1" ;;
    tar) tar tf "$1" ;;
    gz|tgz) tar tzf "$1" ;;
    bz2) tar tjf "$1" ;;
    *) echo "Unknown archive format" ;;
  esac
}
alias lz='ls-archive'

# -- Directory Creation --
mkcd() {
  mkdir -p "$1" && cd "$1"
}

mktouch() {
  [[ -n "$1" ]] && [[ ! -f "$1" ]] && mkdir -p "${1:h}" && touch "$1"
}

# -- Environment Loading --
envup() {
  if [[ -f .env ]]; then
    set -a  # Automatically export all variables
    source .env
    set +a
    echo "Loaded .env"
  else
    echo 'No .env file found' >&2
    return 1
  fi
}

# -- Python Utilities --
pyclean() {
  command find "${@:-.}" -type f -name "*.py[co]" -delete
  command find "${@:-.}" -type d -name "__pycache__" -delete
  command find "${@:-.}" -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
  command find "${@:-.}" -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

# -- File Backup --
backup() {
  [[ -n "$1" ]] && cp -v "$1" "${1}.backup.$(date +%Y%m%d_%H%M%S)"
}

# -- Quick HTTP Server --
serve() {
  local port="${1:-8000}"
  echo "Serving at http://localhost:$port"
  python3 -m http.server "$port"
}

# -- Process Management --
psg() {
  ps aux | rg -i "$1" | rg -v "rg -i $1"
}

killport() {
  local port="$1"
  local pid=$(lsof -ti :"$port" 2>/dev/null)
  if [[ -n "$pid" ]]; then
    echo "Killing process $pid on port $port"
    kill -9 "$pid"
  else
    echo "No process found on port $port"
  fi
}

# -- Git Utilities --
# Unalias git plugin definitions to use custom implementations
unalias gbd 2>/dev/null
gbd() {
  git branch | fzf --multi --preview 'git log --oneline --color=always {1} | head -20' | xargs -r git branch -d
}

unalias gcm 2>/dev/null
gcm() {
  git commit -m "$*"
}

# -- Clipboard Utilities --
cfc() {
  [[ -f "$1" ]] && cat "$1" | xclip -selection clipboard && echo "Copied to clipboard"
}

# -- JSON Pretty Print --
jsonpp() {
  if [[ -f "$1" ]]; then
    python3 -m json.tool "$1" | batcat --language json
  else
    echo "$1" | python3 -m json.tool | batcat --language json
  fi
}

# ============================================================================
# 15. FZF-TAB CONFIGURATION
# ============================================================================
# Configure continuous trigger character for fzf-tab
zstyle ':fzf-tab:*' continuous-trigger '/'

# Preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Preview for kill/ps commands - show process info
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps -p $word -o pid,ppid,user,%cpu,%mem,stat,start,time,command'

# Preview for systemctl commands
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word 2>/dev/null'

# Preview environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'

# Preview for git commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
  'git diff $word | head -100 | batcat --color=always --style=numbers --line-range=:100 2>/dev/null || cat'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
    "modified file") git diff $word | head -100 ;;
    "recent commit object name") git show --color=always $word | head -100 ;;
    *) git log --oneline --color=always $word | head -100 ;;
  esac'

# Preview files with bat when completing general file arguments
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'if [[ -d $realpath ]]; then eza -1 --color=always $realpath; elif [[ -f $realpath ]]; then batcat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || cat $realpath | head -100; fi'

# Switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Enable fzf-tab
zstyle ':fzf-tab:*' fzf-command fzf

# Make fzf-tab trigger immediately
zstyle ':fzf-tab:*' fzf-min-height 15

# Increase fzf-tab popup size for better previews
zstyle ':fzf-tab:*' fzf-flags --height=60% --preview-window=right:50%:wrap

# Rebind Tab to use fzf-tab instead of fzf-completion
bindkey '^I' fzf-tab-complete  # Tab completion via fzf-tab

# ============================================================================
# 16. LOCAL OVERRIDES
# ============================================================================
# Source machine-specific settings from ~/.zshrc.local if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ============================================================================
# 17. NAMED DIRECTORIES
# ============================================================================
# Define shortcuts for frequently accessed directories
# Usage: cd ~projects, ls ~dotfiles, etc.
hash -d projects="$HOME/Projects" 2>/dev/null
hash -d downloads="$HOME/Downloads" 2>/dev/null
hash -d docs="$HOME/Documents" 2>/dev/null
hash -d dotfiles="$HOME/.dotfiles" 2>/dev/null
hash -d config="$HOME/.config" 2>/dev/null

# ============================================================================
# PROFILING OUTPUT
# ============================================================================
# Uncomment to display profiling results when shell is started with zprofrc alias
# [[ "$ZPROFRC" -eq 1 ]] && zprof
