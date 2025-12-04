#!/bin/bash

# stop service and kill processes
sudo systemctl disable resilio-sync
sudo systemctl stop resilio-sync
# Kill all rslsync processes if running
if pgrep rslsync > /dev/null; then
  pkill rslsync
  echo "All rslsync processes killed."
else
  echo "No rslsync processes running."
fi

# remove the package
sudo apt remove --purge -y resilio-sync

# remove repository
sudo rm /etc/apt/sources.list.d/resilio-sync.list

# remove public key
sudo rm /usr/share/keyrings/resilio-sync-keyring.gpg

# remove user and group
sudo deluser --remove-home rslsync

# remove user config
rm -rf ~/.config/resilio-sync
rm ~/.config/systemd/user/default.target.wants/resilio-sync.service
rm ~/.config/systemd/user/resilio-sync.service

# update package lists
sudo apt update

echo "Resilio Sync service and install repositories removed. Do not forget to remove synced data manually."