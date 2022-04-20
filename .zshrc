

export HISTTIMEFORMAT="%d/%m/%y %T "

# export ZSH_THEME="alanpeabody"
export ZSH_THEME="fino-time"
# Remove the background to zsh completion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=1'

# Additional autocompletion
plugins=(
  sdk
  git
  docker
  docker-compose
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export MYZSH_DIR="$HOME/.my-zsh"
[ -s "$MYZSH_DIR/my-zshrc.sh" ] && source "$MYZSH_DIR/my-zshrc.sh"

# Powerline Configuration
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
