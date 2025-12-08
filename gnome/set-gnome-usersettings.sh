#!/bin/bash

# # Set avatar, Set git login name and email ask via gum

# # Path to your avatar image (adjust as needed)
# AVATAR_PATH="/home/$USER/Pictures/avatar.png"

# # Check if the file exists
# if [ ! -f "$AVATAR_PATH" ]; then
#     echo "Error: Avatar image not found at $AVATAR_PATH"
#     exit 1
# fi

# # Set the avatar using gsettings
# gsettings set org.gnome.desktop.user-dirs picture-uri "file://$AVATAR_PATH"

# echo "Avatar set successfully to $AVATAR_PATH"

# git config --global user.name "Dein Name"
# git config --global user.email "deine-email@beispiel.com"
