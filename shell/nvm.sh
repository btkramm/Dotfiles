export NVM_DIR="$HOME/.nvm"

# "\." is the source command, executing both "nvm.sh" and "bash_completion" if
# they exist

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -U add-zsh-hook
load-nvmrc() {
  node_version="$(nvm version)"
  local node_version
  nvmrc_path="$(nvm_find_nvmrc)"
  local nvmrc_path

  if [ -n "$nvmrc_path" ]; then
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    local nvmrc_node_version

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
