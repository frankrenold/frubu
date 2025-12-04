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
echo "Run custom installers..."
bash ./runner.sh installers

# Enable services
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
  if ! systemctl is-enabled "$service" &> /dev/null; then
    echo "Enabling $service..."
    sudo systemctl enable "$service"
  else
    echo "$service is already enabled"
  fi
done

# Add configuration files to .config and all shared files to .local
echo "Writing general configuration and shared files..."
rsync -av --ignore-existing config/ ~/.config
rsync -av --ignore-existing local/ ~/.local

# Install gnome specific things to make it like a tiling WM
echo "Installing Gnome extensions..."
# . gnome/gnome-extensions.sh
echo "Setting Gnome hotkeys..."
# . gnome/gnome-hotkeys.sh
echo "Configuring Gnome..."
# . gnome/gnome-settings.sh

print_done
