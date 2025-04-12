#!/bin/bash

# Hyprland Module Installation
# This script installs and configures Hyprland and related components

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/../../scripts/common.sh"

echo "🚀 Starting Hyprland Setup..."

# Install Hyprland and related components
install_packages "Hyprland window manager" "hyprland"
install_packages "Terminal and file manager" "ghostty dolphin"
install_packages "Text editors" "neovim kate"
install_packages "Document viewer" "okular"
install_packages "Waybar and application launcher" "waybar wofi"
install_packages "Font Awesome (for icons)" "ttf-font-awesome inter-font ttf-nerd-fonts-symbols qt5ct qt5-wayland qt6-wayland"
install_packages "Screenshot and clipboard utilities" "grim slurp wl-clipboard libnotify"
install_packages "Color picker" "hyprpicker"
install_packages "Wallpaper, idle, and key event test" "hyprpaper wev"

# Install AUR packages
install_aur_packages "hyprshot hyprlock swaync"

# Create necessary config directories
ensure_dir "$HOME/.config/hypr"
ensure_dir "$HOME/.config/waybar"

# Backup existing configs if they exist
backup_config "$HOME/.config/hypr"
backup_config "$HOME/.config/waybar"

# Copy config files
copy_config "$(dirname "$0")/config/hypr" "$HOME/.config/hypr"
copy_config "$(dirname "$0")/config/waybar" "$HOME/.config/waybar"

echo "===================================="
echo "✅ Hyprland Setup completed successfully!"
echo "====================================" 