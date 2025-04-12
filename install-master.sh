#!/bin/bash

# Arch Linux Modular Setup Script
# Master installation script that calls individual modules

# Exit on error
set -e

# Configuration directory
CONFIG_DIR="$HOME/.config/arch-setup"
SCRIPTS_DIR="$CONFIG_DIR/scripts"

# Create configuration directory
mkdir -p "$SCRIPTS_DIR"

# Function to check if a command was successful
check_status() {
  if [ $? -eq 0 ]; then
    echo "✅ $1 completed successfully"
  else
    echo "❌ $1 failed"
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

# Copy all scripts to the scripts directory
setup_scripts() {
    echo "Setting up installation scripts..."

    # Write each script to the appropriate file
    cat > "$SCRIPTS_DIR/01-base-system.sh" << 'EOF'
#!/bin/bash
# Base System Setup
# This script installs basic system utilities and configurations

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

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
echo "📁 Creating Scripts directory..."
mkdir -p ~/Scripts
check_status "Scripts directory creation"

# Install basic utilities
install_packages "Basic utilities" "git curl tar unzip wget fd ripgrep fzf jq"

echo "===================================="
echo "✅ Base System Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/01-base-system.sh"

    cat > "$SCRIPTS_DIR/02-hyprland.sh" << 'EOF'
#!/bin/bash
# Hyprland Window Manager Setup
# This script installs Hyprland and related components

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting Hyprland Setup..."

# Install Hyprland and related components
install_packages "Hyprland window manager" "hyprland"
install_packages "Terminal and file manager" "ghostty dolphin"
install_packages "Text editors" "neovim kate"
install_packages "Document viewer" "okular"
install_packages "Waybar and application launcher" "waybar wofi"
install_packages "Font Awesome (for icons)" "ttf-font-awesome inter-font"
install_packages "Screenshot and clipboard utilities" "grim slurp wl-clipboard libnotify"
install_packages "Color picker" "hyprpicker"
install_packages "Wallpaper, idle, and key event test" "hyprpaper wev"

# Create necessary config directories
echo "📁 Creating config directories..."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
check_status "Config directories creation"

# Create advanced Hyprland config
echo "⚙️ Creating Hyprland configuration..."
cat > ~/.config/hypr/hyprland.conf << 'EOCONFIG'
################
### MONITORS ###
################

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor = eDP-1, 1920x1080@60, 0x0, 1

###################
### MY PROGRAMS ###
###################

# Set programs that you use
$terminal = ghostty
$fileManager = dolphin
$menu = wofi --show drun

#################
### VOLUME ######
#################

# Volume control
bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
bind = , XF86AudioMute, exec, pactl set-sink-volume @DEFAULT_SINK@ toggle

# Volume control using function keys if you need to use Fn keys
bind = , F3, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
bind = , F2, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
bind = , F1, exec, pactl set-sink-volume @DEFAULT_SINK@ toggle

#################
### AUTOSTART ###
#################

# Autostart necessary processes
exec-once = nm-applet &
exec-once = waybar & hyprpaper & swaync 

#############################
### ENVIRONMENT VARIABLES ###
#############################

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24

#####################
### LOOK AND FEEL ###
#####################

general {
    gaps_in = 5
    gaps_out = 20

    border_size = 2

    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    resize_on_border = false
    allow_tearing = false

    layout = dwindle
}

decoration {
    rounding = 10
    rounding_power = 2

    active_opacity = 1.0
    inactive_opacity = 1.0

    shadow {
        enabled = true
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
    }

    blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
    }
}

animations {
    enabled = true

    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1

    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade
}

dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

misc {
    force_default_wallpaper = -1
    disable_hyprland_logo = false
}

#############
### INPUT ###
#############

input {
    kb_layout = no
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1
    sensitivity = 0

    touchpad {
        natural_scroll = false
    }
}

gestures {
    workspace_swipe = false
}

device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

###################
### KEYBINDINGS ###
###################

$mainMod = SUPER

# Main bindings
bind = $mainMod, return, exec, $terminal
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, space, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Screenshot and lock
bind = , PRINT, exec, hyprshot -m region
bind = shift, PRINT, exec, hyprshot -m window
bind = $mainMod, l, exec, hyprlock

# Move focus with vi keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, j, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, l, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to workspaces
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mouse
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Laptop multimedia keys
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

# Media controls
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

##############################
### WINDOWS AND WORKSPACES ###
##############################

# Ignore maximize requests from apps
windowrule = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
EOCONFIG

# Create Hyprlock config
echo "🔒 Creating Hyprlock configuration..."
cat > ~/.config/hypr/hyprlock.conf << 'EOCONFIG'
background {
    monitor =
    path = screenshot
    blur_size = 4
    blur_passes = 3
}

input-field {
    monitor =
    size = 200, 50
    position = 0, 0
    halign = center
    valign = center
    capslock-color = rgb(250, 0, 0)
    cursor-color = rgb(200, 200, 200)
    font-color = rgb(200, 200, 200)
    placeholder-text = <i>Password...</i>
    dots-spacing = 0.3
    fade-on-empty = true
    hide-input = false
}

label {
    monitor =
    text = Hi there, $USER!
    color = rgb(200, 200, 200)
    font-size = 20
    position = 0, 70
    halign = center
    valign = center
}
EOCONFIG

# Create hyprpaper config
echo "🖼️ Creating hyprpaper configuration..."
cat > ~/.config/hypr/hyprpaper.conf << 'EOCONFIG'
preload = ~/.config/hypr/wallpaper.jpg
wallpaper = eDP-1,~/.config/hypr/wallpaper.jpg
ipc = off
EOCONFIG

# Download a default wallpaper if needed
echo "🖼️ Downloading a default wallpaper..."
mkdir -p ~/.config/hypr
if [ ! -f ~/.config/hypr/wallpaper.jpg ]; then
    curl -o ~/.config/hypr/wallpaper.jpg https://raw.githubusercontent.com/hyprwm/hyprpaper/main/assets/arch-chan-1.jpg
fi

echo "===================================="
echo "✅ Hyprland Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/02-hyprland.sh"

    cat > "$SCRIPTS_DIR/03-audio-video.sh" << 'EOF'
#!/bin/bash
# Audio and Video Setup
# This script installs audio and brightness control utilities

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting Audio and Video Setup..."

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
echo "✅ Audio and Video Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/03-audio-video.sh"

    cat > "$SCRIPTS_DIR/04-network.sh" << 'EOF'
#!/bin/bash
# Network Setup
# This script installs network management tools

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting Network Setup..."

# Setup NetworkManager
install_packages "Network management" "networkmanager network-manager-applet nm-connection-editor"
echo "🌐 Enabling and starting NetworkManager service..."
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
check_status "NetworkManager setup"

# Setup Bluetooth
install_packages "Bluetooth support" "bluez bluez-utils blueman"
echo "📶 Enabling and starting Bluetooth service..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
check_status "Bluetooth setup"

echo "===================================="
echo "✅ Network Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/04-network.sh"

    cat > "$SCRIPTS_DIR/05-aur.sh" << 'EOF'
#!/bin/bash
# AUR Setup
# This script installs YAY AUR helper and AUR packages

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting AUR Setup..."

# Install YAY AUR helper
echo "📦 Installing YAY AUR helper..."
if ! command -v yay &> /dev/null; then
  sudo pacman -S --needed --noconfirm git base-devel
  cd /opt
  sudo git clone https://aur.archlinux.org/yay.git
  sudo chown -R $USER:$USER yay
  cd yay
  makepkg -si --noconfirm
  check_status "YAY installation"
  cd ~
else
  echo "YAY is already installed"
fi

# Install AUR packages
echo "📦 Installing packages from AUR..."
yay -S --noconfirm hyprshot hyprlock swaync
check_status "AUR packages installation"

# Install web browser (Chrome from AUR)
echo "🌐 Installing Google Chrome..."
yay -S --noconfirm google-chrome
check_status "Google Chrome installation"

echo "===================================="
echo "✅ AUR Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/05-aur.sh"

    cat > "$SCRIPTS_DIR/06-waybar.sh" << 'EOF'
#!/bin/bash
# Waybar Setup
# This script configures Waybar and notification system

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting Waybar Setup..."

# Create Waybar config
echo "⚙️ Creating Waybar configuration..."
mkdir -p ~/.config/waybar
cat > ~/.config/waybar/config.jsonc << 'EOCONFIG'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "bluetooth", "battery", "custom/notification", "tray"],
    
    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "activate",
        "sort-by-number": true
    },
    
    "hyprland/window": {
        "max-length": 50
    },
    
    "clock": {
        "format": "{:%H:%M %Y-%m-%d}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>"
    },
    
    "pulseaudio": {
        "format": "{volume}% {icon}",
        "format-bluetooth": "{volume}% {icon}",
        "format-muted": "󰝟",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", ""]
        },
        "scroll-step": 1,
        "on-click": "pavucontrol"
    },
    
    "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "format-disconnected": "Disconnected ⚠",
        "on-click": "nm-connection-editor"
    },
    
    "bluetooth": {
        "format": " {status}",
        "format-connected": " {device_alias}",
        "format-disconnected": "",
        "on-click": "blueman-manager"
    },
    
    "battery": {
        "format": "{capacity}% {icon}",
        "format-icons": ["", "", "", "", ""]
    },
    
    "custom/notification": {
        "tooltip": false,
        "format": "{icon}",
        "format-icons": {
          "notification": "<span foreground='red'><sup></sup></span>",
          "none": "",
          "dnd-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-none": "",
          "inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "inhibited-none": "",
          "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-inhibited-none": ""
        },
        "return-type": "json",
        "exec-if": "which swaync-client",
        "exec": "swaync-client -swb",
        "on-click": "swaync-client -t -sw",
        "on-click-right": "swaync-client -d -sw",
        "escape": true
    },
    
    "tray": {
        "icon-size": 21,
        "spacing": 10
    }
}
EOCONFIG

# Create SwayNC configuration
echo "🔔 Creating SwayNC configuration..."
mkdir -p ~/.config/swaync
cat > ~/.config/swaync/config.json << 'EOCONFIG'
{
  "$schema": "/etc/xdg/swaync/configSchema.json",
  "positionX": "right",
  "positionY": "top",
  "control-center-margin-top": 10,
  "control-center-margin-bottom": 10,
  "control-center-margin-right": 10,
  "control-center-margin-left": 0,
  "notification-icon-size": 64,
  "notification-body-image-height": 100,
  "notification-body-image-width": 200,
  "timeout": 10,
  "timeout-low": 5,
  "timeout-critical": 0,
  "fit-to-screen": false,
  "control-center-width": 500,
  "control-center-height": 600,
  "notification-window-width": 500,
  "keyboard-shortcuts": true,
  "image-visibility": "when-available",
  "transition-time": 200,
  "hide-on-clear": false,
  "hide-on-action": true,
  "script-fail-notify": true,
  "widgets": [
    "title",
    "dnd",
    "notifications"
  ],
  "widget-config": {
    "title": {
      "text": "Notifications",
      "clear-all-button": true,
      "button-text": "Clear All"
    },
    "dnd": {
      "text": "Do Not Disturb"
    },
    "label": {
      "max-lines": 5,
      "text": "Label Text"
    },
    "mpris": {
      "image-size": 96,
      "image-radius": 12
    }
  }
}
EOCONFIG

# Create style.css for SwayNC
cat > ~/.config/swaync/style.css << 'EOCONFIG'
* {
  all: unset;
  font-family: "Roboto", "Inter", "Font Awesome 6 Free";
  font-size: 14px;
}

.control-center {
  background: rgba(43, 48, 59, 0.95);
  border-radius: 10px;
  border: 2px solid rgba(33, 128, 255, 0.7);
  color: #cdd6f4;
  padding: 8px;
}

.control-center-list {
  background: transparent;
}

.notification {
  background: rgba(30, 30, 46, 0.9);
  border-radius: 10px;
  margin: 6px 0;
  padding: 0;
}

.notification-content {
  background: transparent;
  padding: 10px;
  min-width: 300px;
}

.notification-default-action {
  padding: 4px;
  margin: 0;
}

.close-button {
  background: rgba(180, 190, 254, 0.1);
  border-radius: 100%;
  margin: 10px;
  padding: 2px;
  color: #cdd6f4;
}

.close-button:hover {
  background: rgba(243, 139, 168, 0.3);
  color: #fff;
}
EOCONFIG

echo "===================================="
echo "✅ Waybar Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/06-waybar.sh"

    cat > "$SCRIPTS_DIR/07-dev-setup.sh" << 'EOF'
#!/bin/bash
# Development Environment Setup
# This script installs development tools and configures NeoVim

# Exit on error
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

echo "🚀 Starting Development Environment Setup..."

# Install productivity apps
install_packages "Productivity applications" "obsidian"

# Install development tools (Node.js)
install_packages "Node.js" "nodejs-lts-jod npm"

# Setup LazyVim (NeoVim configuration)
echo "📝 Setting up LazyVim for NeoVim..."
mv ~/.config/nvim{,.bak} 2>/dev/null || true
mv ~/.local/share/nvim{,.bak} 2>/dev/null || true
mv ~/.local/state/nvim{,.bak} 2>/dev/null || true
mv ~/.cache/nvim{,.bak} 2>/dev/null || true
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
check_status "LazyVim setup"

echo "===================================="
echo "✅ Development Environment Setup completed successfully!"
echo "===================================="
EOF
    chmod +x "$SCRIPTS_DIR/07-dev-setup.sh"

    cat > "$SCRIPTS_DIR/common.sh" << 'EOF'
#!/bin/bash
# Common functions used by all scripts

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
EOF
    chmod +x "$SCRIPTS_DIR/common.sh"

    echo "Installation scripts created in $SCRIPTS_DIR"
}

# Main execution
echo "======================================"
echo "🖥️  Arch Linux Modular Setup Script"
echo "======================================"

setup_scripts

# List of script paths in order
SCRIPT_PATHS=(
    "$SCRIPTS_DIR/01-base-system.sh"
    "$SCRIPTS_DIR/02-hyprland.sh"
    "$SCRIPTS_DIR/03-audio-video.sh"
    "$SCRIPTS_DIR/04-network.sh"
    "$SCRIPTS_DIR/05-aur.sh"
    "$SCRIPTS_DIR/06-waybar.sh"
    "$SCRIPTS_DIR/07-dev-setup.sh"
)

# List of script descriptions
SCRIPT_DESCRIPTIONS=(
    "install base system packages and utilities"
    "install and configure Hyprland window manager"
    "set up audio and brightness controls"
    "configure network and bluetooth"
    "install YAY and AUR packages"
    "configure Waybar and notifications"
    "set up development environment"
)

# Execute each script in sequence if the user confirms
for i in "${!SCRIPT_PATHS[@]}"; do
    script="${SCRIPT_PATHS[$i]}"
    description="${SCRIPT_DESCRIPTIONS[$i]}"
    
    if confirm "$description"; then
        echo "Running $(basename "$script")..."
        "$script"
    else
        echo "Skipping $(basename "$script")..."
    fi
done

echo "======================================"
echo "✅ Installation process completed!"
echo "======================================"
echo "You can rerun individual modules at any time from:"
echo "$SCRIPTS_DIR"
echo "======================================"
