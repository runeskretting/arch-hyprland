#!/bin/bash

# Audio Module Installation
# This script installs audio components

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

# Source package configuration
source "$(dirname "$0")/../../packages.conf"

echo "🚀 Starting Audio Setup..."

# Install audio packages
echo "📦 Installing audio packages..."
sudo pacman -S --noconfirm "${AUDIO_PACKAGES[@]}"
check_status "Audio packages installation"

# Enable and start PipeWire services
echo "🔊 Enabling audio services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber
check_status "Audio services setup"

echo "===================================="
echo "✅ Audio Setup completed successfully!"
echo "====================================" 