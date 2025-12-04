#!/bin/bash

# remove the package
sudo apt remove --purge -y code

# remove user config
sudo rm -rf ~/.config/Code

# remove repository
sudo rm /etc/apt/sources.list.d/vscode.sources

# remove public key
sudo rm /usr/share/keyrings/microsoft.gpg

# update package lists
sudo apt update -qq > /dev/null 2>&1

echo "Visual Studio Code and repositories removed."