#!/bin/bash

# Development Tools Module Installation
# This script installs development tools and configurations

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

# Source package configuration
source "$(dirname "$0")/../../packages.conf"

echo "🚀 Starting Development Tools Setup..."

# Install development packages
echo "📦 Installing development packages..."
sudo pacman -S --noconfirm "${DEV_PACKAGES[@]}"
check_status "Development packages installation"

# Setup NeoVim configuration
echo "📋 Setting up NeoVim configuration..."
ensure_dir "$HOME/.config/nvim"
cp "$(dirname "$0")/config/init.lua" "$HOME/.config/nvim/"
check_status "NeoVim configuration setup"

echo "===================================="
echo "✅ Development Tools Setup completed successfully!"
echo "====================================" 