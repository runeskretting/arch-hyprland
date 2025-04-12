#!/bin/bash

# Audio Module Installation
# This script installs audio and brightness control utilities

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

echo "🚀 Starting Audio Setup..."

# Install audio and brightness control
install_packages "PipeWire audio" "pipewire pipewire-pulse wireplumber"
install_packages "Audio volume control" "pavucontrol"
install_packages "Brightness control" "brightnessctl"
install_packages "Media control" "playerctl"

# Enable PipeWire services
echo "🔊 Enabling PipeWire services..."
systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user start pipewire.service pipewire-pulse.service
check_status "PipeWire services setup"

echo "===================================="
echo "✅ Audio Setup completed successfully!"
echo "====================================" 