# Arch Linux Hyprland Setup

This repository contains a modular setup system to install and configure Arch Linux with the Hyprland window manager and related components. The setup is divided into separate modules that can be installed independently, allowing for a customized installation process.

## Overview

The setup is organized into several modules:

1. **Base System**: Core utilities and system packages
2. **Hyprland**: Window manager installation and configuration
3. **Audio/Video**: PipeWire, media controls, and brightness management
4. **Network**: NetworkManager and Bluetooth setup
5. **AUR Setup**: YAY helper and AUR packages
6. **Waybar**: Status bar and notification system
7. **Development**: Development tools and editor setup

## Requirements

- A fresh Arch Linux installation
- Internet connection
- Sudo privileges

## Installation

### Quick Start

1. Download the master installation script:
   ```bash
   curl -O https://github.com/runeskretting/arch-hyprland/install-master.sh
   ```

2. Make it executable:
   ```bash
   chmod +x install-master.sh
   ```

3. Run the script:
   ```bash
   ./install-master.sh
   ```

4. Follow the prompts to install each module.

### Manual Installation

If you prefer to run modules individually:

1. Clone this repository:
   ```bash
   git clone https://github.com/runeskretting/arch-hyprland.git
   cd arch-hyprland-setup
   ```

2. Make scripts executable:
   ```bash
   chmod +x install-master.sh
   ```

3. Run the master script:
   ```bash
   ./install-master.sh
   ```

## Module Details

### 1. Base System Setup (01-base-system.sh)
- System updates
- XDG user directories
- Basic utilities (git, curl, tar, unzip, etc.)

### 2. Hyprland Setup (02-hyprland.sh)
- Hyprland window manager
- Terminal emulator (Ghostty)
- File manager (Dolphin)
- Text editors (Neovim, Kate)
- Document viewer (Okular)
- Hyprland configuration files

### 3. Audio and Video Setup (03-audio-video.sh)
- PipeWire audio system
- Audio control utilities
- Brightness control
- Media playback controls

### 4. Network Setup (04-network.sh)
- NetworkManager and applet
- Bluetooth support and utilities

### 5. AUR Setup (05-aur.sh)
- YAY AUR helper
- Hyprland-related AUR packages
- Google Chrome browser

### 6. Waybar Setup (06-waybar.sh)
- Waybar status bar configuration
- SwayNC notification system
- Custom themes and styling

### 7. Development Setup (07-dev-setup.sh)
- Development tools
- Node.js and npm
- LazyVim (Neovim configuration)
- Obsidian note-taking app

## Customization

### Modifying Configurations

All configuration files are stored in their respective locations:

- Hyprland: `~/.config/hypr/`
- Waybar: `~/.config/waybar/`
- SwayNC: `~/.config/swaync/`
- Neovim: `~/.config/nvim/`

You can edit these files directly to customize your setup.

### Adding New Modules

1. Create a new script in the `~/.config/arch-setup/scripts/` directory
2. Follow the pattern of existing modules
3. Add the script path and description to the arrays in the master script

## Running Individual Modules

After initial setup, you can run individual modules at any time:

```bash
~/.config/arch-setup/scripts/XX-module-name.sh
```

This is useful for updating specific parts of your system or installing modules you initially skipped.

## Troubleshooting

### Common Issues

- **Package installation fails**: Check your internet connection and run `sudo pacman -Syu` to update your system.
- **Configuration errors**: Ensure you have the correct permissions for configuration files.
- **Missing dependencies**: Some modules depend on others. If you skip a module, you might need to install dependencies manually.

### Logs

Each module outputs detailed information about its progress. If something fails, check the output for error messages.

## Contributing

Feel free to fork this repository and adapt it to your needs. Pull requests for improvements or additional modules are welcome.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- The Hyprland team for their excellent window manager
- The Arch Linux community for documentation and packages
