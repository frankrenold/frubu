#!/bin/bash

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes --from https://releases.threema.ch/flatpak/threema-desktop/ch.threema.threema-desktop.flatpakref