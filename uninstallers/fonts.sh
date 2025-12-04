#!/bin/bash

# remove nerd font
rm -rf ~/.local/share/fonts/JetBrainsMonoNerdFont/
fc-cache -fv

echo "Custom Fonts removed."