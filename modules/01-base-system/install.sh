#!/bin/bash

# Base System Module Installation
# This script installs basic system utilities and configurations

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

echo "🚀 Starting Base System Setup..."

# Update system
echo "📦 Updating system packages..."
sudo pacman -Syu --noconfirm
check_status "System update"

# Create XDG user directories
install_packages "XDG user directories" "xdg-user-dirs"
xdg-user-dirs-update
check_status "XDG user directories setup"

# Create Scripts directory
ensure_dir "$HOME/Scripts"

# Install basic utilities
install_packages "Basic utilities" "git curl tar unzip wget fd ripgrep fzf jq"

echo "===================================="
echo "✅ Base System Setup completed successfully!"
echo "====================================" 