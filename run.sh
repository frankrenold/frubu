#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"
    __________  __  ______  __  __
   / ____/ __ \/ / / / __ )/ / / /
  / /_  / /_/ / / / / __  / / / / mostly automated
 / __/ / _, _/ /_/ / /_/ / /_/ /  Custom Ubuntu Setup
/_/   /_/ |_|\____/_____/\____/   by and mainly for Frank

EOF
}

# Print the done message
print_done() {
    cat << "EOF"
         __                     __                         __     
  ____ _/ /___ ___  ____  _____/ /_   ________  ____ _____/ /_  __
 / __ `/ / __ `__ \/ __ \/ ___/ __/  / ___/ _ \/ __ `/ __  / / / /
/ /_/ / / / / / / / /_/ (__  ) /_   / /  /  __/ /_/ / /_/ / /_/ / 
\__,_/_/_/ /_/ /_/\____/____/\__/  /_/   \___/\__,_/\__,_/\__, /  
                                                         /____/
1. REBOOT the system to start everything properly and
2. MANUALY SETUP the last things (~/frubu/README.md)
3. HAVE FUN

EOF
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot
}

# Clear screen and show logo
clear
print_logo

# Exit on any error
set -e

# Source utility functions
source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

# Update the system first
echo "Updating the system ..."
sudo apt update -qq > /dev/null 2>&1 && \
sudo apt -qq -y upgrade > /dev/null 2>&1 && \
sudo apt -qq -y autoremove > /dev/null 2>&1
# Use next line instead for debugging
# sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove

# Install packages by category
echo "Installing system utilities ..."
install_packages "${SYSTEM[@]}"

echo "Installing environment drivers ..."
install_packages "${DRIVERS[@]}"

echo "Installing desktop utilities ..."
install_packages "${DESKTOP_UTILS[@]}"

echo "Installing desktop applications ..."
install_packages "${DESKTOP_APPS[@]}"

echo "Installing developer utilities ..."
install_packages "${DEV[@]}"

# Install snaps
echo "Installing Snaps..."
install_snaps "${SNAP[@]}"

# Install flatpaks
echo "Installing flatpaks"
install_flatpaks "${FLATPAK[@]}"

# Run custom installers
echo "Run custom installers ..."
bash ./runner.sh installers

# Install gnome specific things
echo "Setup Gnome .."
bash ./runner.sh gnome

# Add configuration file to home directory if not yet existing
echo "Writing general configuration and shared files ..."
rsync -av --ignore-existing home/ $HOME

# set zsh as default shell
chsh -s $(which zsh)

print_done
