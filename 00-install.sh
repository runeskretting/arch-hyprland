#!/bin/bash

# Arch Linux Hyprland Setup Script
# Main installer that coordinates module installation

# Exit on error
set -e

# Configuration
CONFIG_DIR="$HOME/.config/arch-hyprland"
MODULES_DIR="$(dirname "$0")/modules"
SCRIPTS_DIR="$(dirname "$0")/scripts"

# Source common functions
source "$SCRIPTS_DIR/common.sh"

# Function to check if a module exists
module_exists() {
    [ -d "$MODULES_DIR/$1" ] && [ -f "$MODULES_DIR/$1/install.sh" ]
}

# Function to install a module
install_module() {
    local module="$1"
    if module_exists "$module"; then
        echo "🚀 Installing $module..."
        "$MODULES_DIR/$module/install.sh"
        check_status "$module installation"
    else
        echo "❌ Module $module not found"
        exit 1
    fi
}

# Function to prompt user for confirmation
confirm() {
    echo
    read -p "🔹 Do you want to $1? (y/n): " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Main execution
echo "======================================"
echo "🖥️  Arch Linux Hyprland Setup Script"
echo "======================================"

# List of available modules in order
MODULES=(
    "01-base-system"
    "02-hyprland"
    "03-audio"
    "04-network"
    "05-dev"
)

# Execute each module if the user confirms
for module in "${MODULES[@]}"; do
    if confirm "install $module"; then
        install_module "$module"
    else
        echo "Skipping $module..."
    fi
done

echo "======================================"
echo "✅ Installation process completed!"
echo "======================================"
echo "You can rerun individual modules at any time from:"
echo "$MODULES_DIR"
echo "======================================" 