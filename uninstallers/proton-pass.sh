#!/bin/bash

# remove package
sudo apt remove -y proton-pass

# remove additianl data
rm -rf ~/.config/'Proton Pass'

echo "Proton Pass Desktop App and configuration files uninstalled."