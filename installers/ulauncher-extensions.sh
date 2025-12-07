#!/bin/bash

sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update
sudo apt install ulauncher -y

# Source utility functions
source utils.sh

EXT_DIR="$HOME/.local/share/ulauncher/extensions"
mkdir -p "$EXT_DIR"

# list of extension git URLs
repos=(
  "https://github.com/Ulauncher/ulauncher-emoji"
  "--branch apiv2 https://github.com/friday/ulauncher-clipboard"
  "https://github.com/iboyperson/ulauncher-system"
)

# matching list of target dir names
names=(
  "com.github.Ulauncher.ulauncher-emoji"
  "com.github.friday.ulauncher-clipboard"
  "com.github.iboyperson.ulauncher-system"
)

for i in "${!repos[@]}"; do
  repo="${repos[$i]}"
  name="${names[$i]}"
  dest="$EXT_DIR/$name"

  if [[ -d "$dest" ]]; then
    echo "Skipping $name (already exists)"
    continue
  fi

  echo "Installing $name from $repo"
  git clone --depth=1 $repo $dest
done

# Start ulauncher in the background
nohup ulauncher >/dev/null 2>&1 &
sleep 1
echo "🚀 Ulauncher started .."

# Setup configs
sed -i 's|theme-name": "[^"]*"|theme-name": "ubuntu"|g' ~/.config/ulauncher/settings.json
sed -i 's|show-indicator-icon": true|show-indicator-icon": false|g' ~/.config/ulauncher/settings.json

stop_all "ulauncher"

# Start ulauncher in the background
nohup ulauncher >/dev/null 2>&1 &
sleep 1
echo "🚀 Ulauncher started .."