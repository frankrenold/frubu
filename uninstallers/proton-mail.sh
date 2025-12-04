#!/bin/bash

# remove package
sudo apt remove -y proton-mail

# remove additianl data
rm -rf ~/.config/'Proton Mail'

echo "Proton Mail Desktop App and configuration files uninstalled."