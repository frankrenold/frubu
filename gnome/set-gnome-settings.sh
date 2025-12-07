#!/bin/bash

# Center new windows in the middle of the screen
gsettings set org.gnome.mutter center-new-windows true

# Reveal week numbers in the Gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# Turn off ambient sensors for setting screen brightness (they rarely work well!)
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

# Trun on scrolling in natural direction
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true

# Aktiviere Night Light
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# Setze Zeitplan auf „Automatisch“ (Sonnenuntergang bis Sonnenaufgang)
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true

# Farbtemperatur anpassen (z. B. 1500K)
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 1500

# Akkuladung in % anzeigen
gsettings set org.gnome.desktop.interface show-battery-percentage true
