#!/bin/bash

DOWNLOAD_PAGE="https://protonapps.com/"
LATEST_DEB_URL=$(curl -s $DOWNLOAD_PAGE | grep -oP '(https://[^"]+ProtonMail[^"]+\.deb)' | head -n 1)

if [ -z "$LATEST_DEB_URL" ]; then
  echo "No Proton Mail Download URL found on: $DOWNLOAD_PAGE"
  exit 1
else
  echo "Found Proton Mail Download URL: $LATEST_DEB_URL"
fi

# Define file name
DEB_FILE="ProtonMail.deb"

# Download the latest Proton Mail Desktop DEB package
echo "Downloading Proton Mail Desktop App..."
wget -O $DEB_FILE $LATEST_DEB_URL

# Check if download succeeded
if [ $? -ne 0 ]; then
  echo "Download failed. Please check the URL or your internet connection."
  exit 1
fi

# Install the DEB package
echo "Installing Proton Mail Desktop App..."
sudo apt install -y ./$DEB_FILE

# Clean up
rm $DEB_FILE

echo "Proton Mail Desktop App installation complete."
