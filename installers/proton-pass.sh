#!/bin/bash

DOWNLOAD_PAGE="https://protonapps.com/"
LATEST_DEB_URL=$(curl -s $DOWNLOAD_PAGE | grep -oP '(https://[^"]+ProtonPass[^"]*\.deb)' | head -n 1)

if [ -z "$LATEST_DEB_URL" ]; then
  echo "No Proton Pass Download URL found on: $DOWNLOAD_PAGE"
  exit 1
else
  echo "Found Proton Pass Download URL: $LATEST_DEB_URL"
fi

# Define file name
DEB_FILE="ProtonPass.deb"

# Download the latest Proton Passs Desktop DEB package
echo "Downloading Proton Pass Desktop App..."
wget -O $DEB_FILE $LATEST_DEB_URL

# Check if download succeeded
if [ $? -ne 0 ]; then
  echo "Download failed. Please check the URL or your internet connection."
  exit 1
fi

# Install the DEB package
echo "Installing Proton Pass Desktop App..."
sudo apt install -y ./$DEB_FILE

# Clean up
rm $DEB_FILE

echo "Proton Pass Desktop App installation complete."
