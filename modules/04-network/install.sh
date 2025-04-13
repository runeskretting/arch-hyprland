#!/bin/bash

# Network Module Installation
# This script installs network management components

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

# Source package configuration
source "$(dirname "$0")/../../packages.conf"

echo "🚀 Starting Network Setup..."

# Install network packages
echo "📦 Installing network packages..."
sudo pacman -S --noconfirm "${NETWORK_PACKAGES[@]}"
check_status "Network packages installation"

# Enable NetworkManager service
echo "🌐 Enabling NetworkManager service..."
sudo systemctl enable --now NetworkManager
check_status "NetworkManager service setup"

echo "===================================="
echo "✅ Network Setup completed successfully!"
echo "====================================" 