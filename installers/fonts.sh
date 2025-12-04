#!/bin/bash

echo "Installing custom Fonts"

# Nerd Font laden
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir -p JetBrainsMonoNerdFont
tar -xJf JetBrainsMono.tar.xz -C ./JetBrainsMonoNerdFont/
mv JetBrainsMonoNerdFont/ ~/.local/share/fonts
fc-cache -fv
rm JetBrainsMono.tar.xz
echo "JetBrainsMono Nerd Font installed."