#!/bin/bash
WALLPAPER="$HOME/frubu/themes/frubu/background.jpg"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
# gsettings set org.gnome.desktop.background picture-uri-dark "file://dark-$WALLPAPER"
gsettings set org.gnome.desktop.background picture-options 'zoom'
echo "Wallpaper set to $WALLPAPER"
