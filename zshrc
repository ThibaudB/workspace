export HISTTIMEFORMAT="%d/%m/%y %T "

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH_THEME="agnoster"
#export ZSH_THEME="powerlevel9k/powerlevel9k"

export BIN="$HOME/.bin"
export FUNCTION="$HOME/.function"

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

source $ZSH/oh-my-zsh.sh

for src in `ls $FUNCTION/*`; do
  source $src
done;

# Reset PATH to initial PATH
if [ -z "${OLD_PATH}" ]; then
  echo "save path: $PATH"
  export OLD_PATH=$PATH
else
  echo "load path: $OLD_PATH"
  export PATH=$OLD_PATH
fi;

echo "current path: $PATH"

# Exports
export PROFILE="$HOME/.zshrc"
export WORKSPACE="$HOME/workspace"
export APP="$WORKSPACE/app"
export EDITOR='vi'

# Alias
alias reload="source $PROFILE"
alias clean-link="find -L $LINK -name . -o -type d -prune -o -type l -exec rm {} +"

# Exports
export PROFILE="$HOME/.zshrc"
export WORKSPACE="$HOME/workspace"
export APP="$WORKSPACE/app"
export PULSAR="$APP/pulsar"
export LINK=~/link

if [ -f "$PROFILE.local" ] ; then
  source "$PROFILE.local"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/thibaudb/.sdkman"
export SDKMAN_APPS="$SDKMAN_DIR/candidates"
[[ -s "/Users/thibaudb/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/thibaudb/.sdkman/bin/sdkman-init.sh"
#THIS MUST BE AT THE END OF THE FILE FOR DXV3 DEPLOYMENT TO WORK!!!
export DXV3_DEPLOYMENT_DIR=/Users/thibaudb/workspace/project/dxv3/deployment
[[ -s "/Users/thibaudb/workspace/project/dxv3/deployment/scripts/init.sh" ]] && source "/Users/thibaudb/workspace/project/dxv3/deployment/scripts/init.sh"
