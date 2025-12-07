#!/bin/bash

# Importiere den Resilio Sync GPG-Schlüssel
curl -sL https://linux-packages.resilio.com/resilio-sync/key.asc | sudo gpg --dearmor -o /usr/share/keyrings/resilio-sync-keyring.gpg

# Füge das Repository hinzu
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/resilio-sync-keyring.gpg] https://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list

# Lade die Paketliste neu und installiere Resilio Sync
sudo apt update
sudo apt install resilio-sync

# Kopiere Lizenz in tmp, um sie da auszuwählen
sudo cp config/resilio-sync-licencse.btskey /tmp/

# Starte und aktiviere Resilio Sync, sodass es beim Booten automatisch mit startet
sudo sed -i 's/WantedBy=multi-user.target/WantedBy=default.target/g' /usr/lib/systemd/user/resilio-sync.service

systemctl --user enable resilio-sync
systemctl --user start resilio-sync

echo "Resilio Sync service installed. The servicse will be started with you next login. Please add the licence (is in /tmp) and sync directories manually."