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

# Install gum (https://github.com/charmbracelet/gum) for fancy shell scripts
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum

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
gum spin --spinner meter --title "Update the full system ..." -- sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoremove

# Install packages by category
echo "Installing system utilities..."
install_packages "${SYSTEM[@]}"

echo "Installing environment drivers..."
install_packages "${DRIVERS[@]}"

echo "Installing desktop utilities..."
install_packages "${DESKTOP_UTILS[@]}"

echo "Installing desktop applications..."
install_packages "${DESKTOP_APPS[@]}"

echo "Installing developer utilities..."
install_packages "${DEV[@]}"

# Install snaps
echo "Install Snaps..."
install_snaps "${SNAP[@]}"

# Some programs just run better as flatpaks. Like discord/spotify
echo "Installing flatpaks (like discord and spotify)"
# . install-flatpaks.sh

print_done
