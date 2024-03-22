# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="dracula"


# Loading catppuccin zsh-syntax-highlighting theme before
# zsh-syntax-highlighting is loaded
source ~/Development/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	history
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# History file configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=20000

# History command configuration
setopt INC_APPEND_HISTORY       # write to history file immediately, not when the shell exists
setopt HIST_EXPIRE_DUPS_FIRST   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS         # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE        # ignore commands that start with space
setopt HIST_VERIFY              # show command with history expansion to user before running it
setopt SHARE_HISTORY            # share command history data between all sessions

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export GOPATH=$HOME/Development/go
export PATH=$GOPATH/bin:$PATH

export GOPRIVATE=*.experienceone.com

export PROJECTS=$HOME/Development/Projects

if type nvim > /dev/null 2>&1; then
	alias vim='nvim'
fi

export VISUAL=vim
export EDITOR=$VISUAL

alias git='LANG=en_US.UTF-8 git'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# PYTHON
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# JAVA
if command -v jenv 1>/dev/null 2>&1; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# KUBECONFIG
export KUBECONFIG="$(ls -1p ~/.kube/config ~/.kube/*.kubecfg | xargs echo | sed 's/ /:/g')"

# Setup starship prompt
eval "$(starship init zsh)"
