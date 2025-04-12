#!/bin/bash

# Network Module Installation
# This script installs network management tools

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

echo "🚀 Starting Network Setup..."

# Setup NetworkManager
install_packages "Network management" "networkmanager network-manager-applet nm-connection-editor"
echo "🌐 Enabling and starting NetworkManager service..."
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
check_status "NetworkManager setup"

# Setup Bluetooth
install_packages "Bluetooth support" "bluez bluez-utils blueman"
echo "📶 Enabling and starting Bluetooth service..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
check_status "Bluetooth setup"

echo "===================================="
echo "✅ Network Setup completed successfully!"
echo "====================================" 