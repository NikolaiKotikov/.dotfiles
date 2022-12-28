#--------------------------------------------------------------------------
# Oh My Zsh
#--------------------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  nvm
  command-not-found
  sudo
  fzf
)

VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

zstyle ':omz:plugins:nvm' autoload yes

source $ZSH/oh-my-zsh.sh

#--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export PATH=$HOME/bin:$HOME/.local/scripts:$HOME/.local/bin:/usr/local/bin:$PATH

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias so="source ~/.zshrc"
alias lg="lazygit"
alias ta="tmux-sessionizer"
alias vim="nvim"

#--------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------

function jp() {
  selected=$(find ~/Projects -maxdepth 3 -mindepth 3 -type d | fzf)

  if [[ -z $selected ]]; then
    return
  fi

  cd $selected
}

function exp() {
  if [[ $1 ]]; then
    selected=$1
  else
    selected="."
  fi

  explorer.exe $selected
}

#--------------------------------------------------------------------------
# Miscellaneous
#--------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
