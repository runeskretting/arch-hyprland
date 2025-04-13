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

# Check if NeoVim config exists
if [ ! -f "$HOME/.config/nvim/init.lua" ] && [ ! -f "$HOME/.config/nvim/init.vim" ]; then
    echo "📋 Setting up NeoVim configuration..."
    ensure_dir "$HOME/.config/nvim"
    if [ -f "$(dirname "$0")/config/init.lua" ]; then
        cp "$(dirname "$0")/config/init.lua" "$HOME/.config/nvim/"
        check_status "NeoVim configuration setup"
    else
        echo "ℹ️ No default NeoVim configuration found, skipping..."
    fi
else
    echo "ℹ️ NeoVim configuration already exists, skipping..."
fi

echo "===================================="
echo "✅ Development Tools Setup completed successfully!"
echo "====================================" 