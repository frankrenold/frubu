#!/bin/bash

# Create Brave Profiles (if installed as flatpak)
# mkdir -p ~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile-YouTube
# mkdir -p ~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile-Perplexity
# mkdir -p ~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile-kSuite
# mkdir -p ~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile-SynologyPhotos
# mkdir -p ~/.var/app/com.brave.Browser/config/BraveSoftware/Brave-Browser/Profile-AppleMusic

# Create Brave Profiles (if installed as snap)
# mkdir -p ~/snap/brave/current/.config/BraveSoftware/Brave-Browser/Profile-YouTube
# mkdir -p ~/snap/brave/current/.config/BraveSoftware/Brave-Browser/Profile-Perplexity
# mkdir -p ~/snap/brave/current/.config/BraveSoftware/Brave-Browser/Profile-kSuite
# mkdir -p ~/snap/brave/current/.config/BraveSoftware/Brave-Browser/Profile-SynologyPhotos
# mkdir -p ~/snap/brave/current/.config/BraveSoftware/Brave-Browser/Profile-AppleMusic

# Create Brave Profiles (if installed as apt package)
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Profile-YouTube
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Profile-Perplexity
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Profile-kSuite
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Profile-SynologyPhotos
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Profile-AppleMusic

# Add all .desktop files and icons
rsync -av --ignore-existing local/ ~/.local
