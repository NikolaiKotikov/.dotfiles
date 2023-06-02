#--------------------------------------------------------------------------
# Oh My Zsh
#--------------------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  zsh-autosuggestions
  nvm
  command-not-found
  sudo
)

zstyle ':omz:plugins:nvm' autoload yes

source $ZSH/oh-my-zsh.sh

#--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------

export PATH=$HOME/bin:$HOME/scripts:$HOME/.local/bin:/usr/local/bin:$PATH

export JAVA_HOME=/home/nik/.sdkman/candidates/java/current
export DISABLE_AUTO_TITLE='true'

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------
alias so="source ~/.zshrc"

alias conf="nvim ~/.zshrc"

alias vim="nvim"

alias ya="yadm"

alias vpn-restart="sudo systemctl restart openvpn-client@default"
alias vpn-status="sudo systemctl status openvpn-client@default"

alias mc-start="tmuxp load mc"
alias mc-rebuild="cd ~/repos/moysklad/moysklad-all \
&& ./rebuild-webkit.sh \
&& ./build-protobuf.sh \
&& docker-compose down \
&& docker system prune --volumes -f \
&& ./run-infrastructure.sh \
&& ./convert.sh \
&& cd ../user-directory \
&& ./convert.sh \
&& ./rebuild.sh \
&& cd ../frontend-react \
&& npm run setup"

alias tailscale-up="sudo tailscale up \
--login-server=https://headscale.lognex.ru \
--accept-routes=true \
--shields-up=true"
#--------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------

function ws() {
    (webstorm "$@" & ) > /dev/null 2>&1
}

#--------------------------------------------------------------------------
# Miscellaneous
#--------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
