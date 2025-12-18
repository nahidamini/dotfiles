#!/usr/bin/env bash
set -e

# Location of custom Oh My Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
PLUGIN_DIR="$ZSH_CUSTOM/plugins"

mkdir -p "$PLUGIN_DIR"
cd "$PLUGIN_DIR"

# List of plugins to ensure
declare -A plugins

# Plugins that are in Oh My Zsh by default (no git needed)
# These can just be referenced in .zshrc
plugins["git"]=""
plugins["docker"]=""
plugins["docker-compose"]=""
plugins["virtualenv"]=""
plugins["brew"]=""
plugins["history"]=""
plugins["npm"]=""
plugins["node"]=""
plugins["pip"]=""
plugins["python"]=""
plugins["autojump"]=""

# Plugins that need to be cloned from GitHub
plugins["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
plugins["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
plugins["asdf"]="https://github.com/asdf-vm/asdf.git"

echo "Ensuring plugins are installed and up-to-date..."

for plugin in "${!plugins[@]}"; do
    repo_url="${plugins[$plugin]}"
    if [[ -z "$repo_url" ]]; then
        echo "Skipping $plugin (bundled with Oh My Zsh)"
        continue
    fi

    if [ ! -d "$plugin" ]; then
        echo "Cloning $plugin..."
        git clone "$repo_url" "$plugin"
    else
        echo "Updating $plugin..."
        cd "$plugin"
        git pull origin master
        cd ..
    fi
done

echo "All plugins installed and updated successfully."
