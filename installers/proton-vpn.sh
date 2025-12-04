#!/bin/bash

DOWNLOAD_PAGE="https://repo.protonvpn.com/debian/dists/stable/main/binary-all/"
LATEST_DEB_FILE=$(curl -s $DOWNLOAD_PAGE | grep -oP '(protonvpn-stable-release_[\d\.-]+_all\.deb)' | sort -V | uniq | tail -n 1)

if [ -z "$LATEST_DEB_FILE" ]; then
  echo "No Proton VPN Download URL found on: $DOWNLOAD_PAGE"
  exit 1
else
  echo "Found Proton VPN Download URL: $DOWNLOAD_PAGE$LATEST_DEB_FILE"
fi
./under
# Define file name
DEB_FILE="ProtonVPN.deb"

# Download the latest Proton VPN Desktop DEB package
echo "Downloading Proton VPN Desktop App ..."
wget -O $DEB_FILE $DOWNLOAD_PAGE$LATEST_DEB_FILE

# Check if download succeeded
if [ $? -ne 0 ]; then
  echo "Download failed. Please check the URL or your internet connection."
  exit 1
fi

# Install the Proton VPN repository
echo "Install the Proton VPN repository ..."
sudo dpkg -i ./$DEB_FILE && sudo apt update -qq > /dev/null 2>&1

# Install the Proton VPN GNOME App
echo "Install the Proton VPN Desktop App for GNOME ..."
sudo apt install -y proton-vpn-gnome-desktop

# Clean up
rm $DEB_FILE

echo "Proton VPN Desktop App installation complete."