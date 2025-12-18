# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

# Path configurations
export NODE_PATH=$NODE_PATH:$HOME/.npm-global/lib/node_modules
export JAVA_HOME=/usr/java/latest
export PATH=$JAVA_HOME/bin:~/.npm-global/bin:$HOME/bin:/usr/local/bin:$PATH
export PATH="/Users/namini/.rd/bin:$PATH"
export PATH="/opt/homebrew/opt/go@1.23/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"
export PATH="/Users/namini/.codeium/windsurf/bin:$PATH"
export PATH="/Users/namini/.antigravity/antigravity/bin:$PATH"

# Dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT

# Add exports from your profile
source ~/.profile

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh-my-zsh settings
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    docker-compose
    virtualenv
    asdf
    brew
    history
    npm
    node
    pip
    python
    autojump
)

source $ZSH/oh-my-zsh.sh
~/.oh-my-zsh/update-plugins.sh &> /dev/null &


# AWS Completion
if command -v aws 1>/dev/null 2>&1; then
    if test -f "/usr/local/bin/aws_completer"; then
        complete -C '/usr/local/bin/aws_completer' aws
    elif test -f "${HOME}/.asdf/shims/aws_completer"; then
        complete -C "${HOME}/.asdf/shims/aws_completer" aws
    fi
fi

if command -v aws-vault 1>/dev/null 2>&1; then
    alias ai='aws-vault exec dil-team-ai-research --'
    alias link='aws-vault exec dil-team-link --'
    alias afc='aws-vault exec dil-afc-dev --'
    
    if test -f "/usr/local/bin/aws_completer"; then
        complete -C '/usr/local/bin/aws_completer' aws-vault
    elif test -f "${HOME}/.asdf/shims/aws_completer"; then
        complete -C "${HOME}/.asdf/shims/aws_completer" aws-vault
    fi
fi

# Aliases 
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias lt='ls -lahtFr'

# General aliases
alias count='find . -type f | wc -l'
alias ag='alias | grep'
alias av="aws-vault"
alias c='cursor'
alias wh='which'
alias mkdir='mkdir -pv'
alias b='brew'
alias bi='brew install'

# Git aliases
alias cg='cd `git rev-parse --show-toplevel`'
alias gcm='git checkout main'
alias hs='history|grep'
alias gil="git log --pretty=format:'%H' -n 1 | pbcopy"
alias gamf='git status -s | grep "^ M" | cut -c 4- | xargs git add'

# Python alias
alias python='python3.11'

# Diligent AI login
alias dcl='
  export AWS_REGION=us-west-2 &&
  export CLAUDE_CODE_USE_BEDROCK=1 &&
  aws sso login --profile dil-team-ai-research &&
  export AWS_PROFILE="dil-team-ai-research"
'

# Functions
function af() {
  rg 'function.*?#' ~/.zshrc | \
  sed 's/^[ \t]*//g;s/^function //' | \
  rg -v '^#|rg ' | \
  awk 'BEGIN {FS = "{.*# "}; { printf "\033[36m%-20s\033[0m %s\n", $1, $2}'
}

function note() { echo `date +"%Y-%m-%d %H:%M:%S  "`"$*" >> ~/notes; }

function notes() { vim + ~/notes; }

function gotit() { history -2 | tail -n 1 | cut -c 8- >> ~/notes; }

if command -v youtube-dl 1>/dev/null 2>&1; then
    function yda() {
        youtube-dl -cix --audio-format mp3 "$@"
    }
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Autojump
[[ -s /Users/namini/.autojump/etc/profile.d/autojump.sh ]] && source /Users/namini/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

# Gitstatus
source ~/gitstatus/gitstatus.prompt.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
