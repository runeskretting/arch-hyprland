#!/bin/bash
# Common functions used by all modules

# Function to check if a command was successful
check_status() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 completed successfully"
    else
        echo "❌ $1 failed"
        exit 1
    fi
}

# Function to install packages with pacman
install_packages() {
    echo "📦 Installing $1..."
    sudo pacman -S --needed --noconfirm $2
    check_status "$1 installation"
}

# Function to install AUR packages with yay
install_aur_packages() {
    echo "📦 Installing AUR packages: $1..."
    yay -S --needed --noconfirm $1
    check_status "AUR packages installation"
}

# Function to create directory if it doesn't exist
ensure_dir() {
    echo "📁 Creating directory: $1"
    mkdir -p "$1"
    check_status "Directory creation: $1"
}

# Function to backup existing config
backup_config() {
    local config_path="$1"
    if [ -e "$config_path" ]; then
        echo "📦 Backing up existing config: $config_path"
        mv "$config_path" "${config_path}.bak"
        check_status "Config backup: $config_path"
    fi
}

# Function to create symlink
create_symlink() {
    echo "🔗 Creating symlink: $1 -> $2"
    ln -sf "$1" "$2"
    check_status "Symlink creation: $1 -> $2"
}

# Function to copy config
copy_config() {
    echo "📋 Copying config: $1 -> $2"
    cp -r "$1" "$2"
    check_status "Config copy: $1 -> $2"
} 