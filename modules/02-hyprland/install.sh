#!/bin/bash

# Hyprland Module Installation
# This script installs Hyprland and its dependencies

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

# Source package configuration
source "$(dirname "$0")/../../packages.conf"

echo "🚀 Starting Hyprland Setup..."

# Install Hyprland and dependencies
echo "📦 Installing Hyprland and display packages..."
sudo pacman -S --noconfirm "${HYPRLAND_PACKAGES[@]}"
check_status "Hyprland packages installation"

# Create Hyprland config directory
ensure_dir "$HOME/.config/hypr"

# Copy Hyprland configuration
echo "📋 Copying Hyprland configuration..."
cp "$(dirname "$0")/config/hyprland.conf" "$HOME/.config/hypr/"
check_status "Hyprland configuration copy"

echo "===================================="
echo "✅ Hyprland Setup completed successfully!"
echo "====================================" 