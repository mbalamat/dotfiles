# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="eastwood"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(
#  gitfast
#  vi-mode
#  z
#)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias m='mycli -u root -proot'
if command -v nvim >/dev/null 2>&1; then
  alias vim='nvim'
  export EDITOR='nvim'
fi

command -v yarn >/dev/null 2>&1 && export PATH="$PATH:$HOME/.yarn/bin"
if command -v npm >/dev/null 2>&1; then
  mkdir -p ~/.npm-global
  export PATH="$PATH:$HOME/.npm-global/bin"
  export NPM_CONFIG_PREFIX=~/.npm-global
fi
command -v go >/dev/null 2>&1 && export PATH="$PATH:$HOME/go/bin"
[ -d $HOME/.prefix/usr/local/bin ] && export PATH="$PATH:$HOME/.prefix/usr/local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.cargo/bin:$PATH"
alias l="ls"
alias ll="ls -lah"
export PATH="/usr/local/sbin:$PATH"
alias yolo="git add . && git commit -m 'YOLO' && g push origin master || echo 'Something failed during yoling git!'"
alias k="kubectl $@"

getRandomString () {perl -pe 'binmode(STDIN, ":bytes"); tr/A-Za-z0-9//dc;' < /dev/urandom | head -c 64; echo}

function rebasethis {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 || return 1
  [ $(pwd) = '/Users/mbalamat' ] && return 2
  [ $(git rev-parse --git-dir) = '/Users/mbalamat/.git' ] && return 3
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  if [ "$CURRENT_BRANCH" = 'master' ]; then
    echo "ERROR: You are on branch master, do a git pull first"
  else
    git checkout master && git pull origin master && git checkout $CURRENT_BRANCH && git rebase master
  fi
}

function tmuxkillall {
  tmux list-panes -s -F "#{pane_pid} #{pane_current_command}" | grep -v tmux | awk '{print $1}' | xargs kill -9
}

function decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}
