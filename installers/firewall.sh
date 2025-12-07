#!/bin/bash

# Firewall aktivieren
echo "Aktiviere die Firewall..."
sudo ufw enable

# Status anzeigen
echo "Firewall-Status:"
sudo ufw status verbose

echo "Firewall wurde erfolgreich aktiviert."