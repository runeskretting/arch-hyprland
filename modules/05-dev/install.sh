#!/bin/bash

# Development Module Installation
# This script installs development tools and configures NeoVim

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

echo "🚀 Starting Development Environment Setup..."

# Install productivity apps
install_packages "Productivity applications" "obsidian"

# Install development tools (Node.js)
install_packages "Node.js" "nodejs-lts-jod npm"

# Setup LazyVim (NeoVim configuration)
echo "📝 Setting up LazyVim for NeoVim..."
backup_config "$HOME/.config/nvim"
backup_config "$HOME/.local/share/nvim"
backup_config "$HOME/.local/state/nvim"
backup_config "$HOME/.cache/nvim"

git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"
check_status "LazyVim setup"

echo "===================================="
echo "✅ Development Environment Setup completed successfully!"
echo "====================================" 