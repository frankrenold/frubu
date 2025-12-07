#!/bin/bash

# Visual Code must be installed in classic mode and can change the system outside the sandbox. It may be not secure and should be replaced by another ide/editor (neovim?)

# Download and install Microsoft's GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo install -D -o root -g root -m 644 /dev/stdin /usr/share/keyrings/microsoft.gpg

# Füge das Repository hinzu
cat <<EOF | sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

# Lade die Paketliste neu und installiere Visual Studio Code
sudo apt update -qq && sudo apt -y install code

# Update settings
SETTINGS_FILE="$HOME/.config/Code/User/settings.json"
mkdir -p "$(dirname "$SETTINGS_FILE")"
[ ! -f "$SETTINGS_FILE" ] && echo "{}" > "$SETTINGS_FILE"

# Function to update a setting
update_code_setting() {
    local key="$1"
    local value="$2"
    local settings_file="$3"

    jq --arg key "$key" --argjson value "$value" \
    '.[$key] = $value' "$settings_file" > "$settings_file.tmp" && \
    mv "$settings_file.tmp" "$settings_file"

    echo "✅ VS Code Setting '$key' updated to $value"
}

update_code_setting "editor.fontFamily" "\"'JetBrainsMono Nerd Font'\"" "$SETTINGS_FILE"
update_code_setting "terminal.integrated.fontSize" "14" "$SETTINGS_FILE"

echo "Visual Studio Code installed"
