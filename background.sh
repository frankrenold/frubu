#!/bin/bash
WALLPAPER="$HOME/Sync/frank/Desktop/Hintergrundbilder/grosser-tiger.jpg"
# Export display/session addresses so gsettings can be used outside a terminal
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
# Apply the wallpaper for the current GNOME session
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
echo "Wallpaper set to $WALLPAPER"

