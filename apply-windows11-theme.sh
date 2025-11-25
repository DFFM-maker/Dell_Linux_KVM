#!/bin/bash
#
# GNOME Windows 11-like Theme Application Script
# This script customizes GNOME to look and feel like Windows 11
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as regular user (not root)
if [ "$EUID" -eq 0 ]; then
    print_error "Please run this script as a regular user (without sudo)"
    exit 1
fi

print_info "GNOME Windows 11-like Theme Application Script"
echo ""

# Check if running GNOME
if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
    print_warning "You don't appear to be running GNOME desktop."
    read -p "Do you want to continue anyway? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        print_error "Aborting."
        exit 1
    fi
fi

# Install required tools
print_info "Installing required packages..."
sudo dnf install -y gnome-tweaks gnome-extensions-app gnome-shell-extension-user-theme wget

# Enable GNOME extensions
print_info "Enabling GNOME Shell extensions..."
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com 2>/dev/null || true

# Create directories for themes and icons
print_info "Creating theme directories..."
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.local/share/gnome-shell/extensions

# Function to install GNOME extension
install_extension() {
    local extension_id=$1
    local extension_name=$2
    
    print_info "Installing $extension_name extension..."
    
    # Download and install extension using gnome-extensions
    # Note: This requires gnome-shell-extension-installer or manual installation
    print_warning "Please install the following extensions manually from extensions.gnome.org:"
    echo "  - $extension_name"
}

# List of recommended extensions for Windows 11-like experience
print_info "Recommended GNOME Extensions for Windows 11 look:"
echo ""
echo "Please install these extensions from https://extensions.gnome.org:"
echo ""
echo "1. Dash to Panel (or Dash to Dock)"
echo "   - Moves the dash to the bottom panel"
echo "   - Makes it look like Windows taskbar"
echo "   - ID: dash-to-panel@jderose9.github.com"
echo ""
echo "2. Arc Menu"
echo "   - Provides a Windows 11-style start menu"
echo "   - ID: arcmenu@arcmenu.com"
echo ""
echo "3. Blur my Shell"
echo "   - Adds blur effects like Windows 11"
echo "   - ID: blur-my-shell@aunetx"
echo ""
echo "4. Just Perfection"
echo "   - Customize GNOME Shell visibility"
echo "   - ID: just-perfection-desktop@just-perfection"
echo ""
echo "5. Window Rounded Corners"
echo "   - Adds rounded corners to windows"
echo "   - ID: rounded-window-corners@yilozt"
echo ""

# Prompt user to install extensions
read -p "Press Enter to continue once you've installed the extensions, or Ctrl+C to exit..."

# Configure GNOME settings for Windows 11-like appearance
print_info "Configuring GNOME settings..."

# Set button layout (close, minimize, maximize on the right like Windows)
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# Set theme to dark (Windows 11 default)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Enable hot corner
gsettings set org.gnome.desktop.interface enable-hot-corners true

# Set fonts
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'

# Download and install Windows 11-like GTK theme
print_info "Installing Windows 11-inspired GTK theme..."

THEME_DIR="$HOME/.themes"
mkdir -p "$THEME_DIR"

# Try to download a Windows 11-like theme
print_info "Downloading WhiteSur GTK theme (Windows-like appearance)..."
if command -v git &> /dev/null; then
    cd /tmp
    if [ -d "WhiteSur-gtk-theme" ]; then
        rm -rf WhiteSur-gtk-theme
    fi
    
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
    cd WhiteSur-gtk-theme
    ./install.sh -c Dark -t blue -N glassy
    cd ..
    
    print_info "WhiteSur theme installed successfully!"
    
    # Apply the theme
    gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-blue'
    gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-blue'
else
    print_warning "git not found. Skipping theme installation."
fi

# Download and install Windows 11-like icon theme
print_info "Installing Windows 11-inspired icon theme..."
cd /tmp
if [ -d "WhiteSur-icon-theme" ]; then
    rm -rf WhiteSur-icon-theme
fi

if command -v git &> /dev/null; then
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
    cd WhiteSur-icon-theme
    ./install.sh -b
    cd ..
    
    print_info "WhiteSur icon theme installed successfully!"
    
    # Apply icon theme
    gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
else
    print_warning "git not found. Skipping icon theme installation."
fi

# Configure wallpaper
print_info "Setting up wallpaper..."
# You can download a Windows 11-style wallpaper here
print_info "You may want to set a Windows 11-like wallpaper manually."
print_info "Right-click on desktop -> Change Background"

# Configure keyboard shortcuts similar to Windows
print_info "Configuring Windows-like keyboard shortcuts..."

# Super key to open activities (like Windows key opening Start menu)
gsettings set org.gnome.mutter overlay-key 'Super_L'

# Show desktop (Super+D)
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

# Close window (Alt+F4)
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4']"

# Lock screen (Super+L)
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>l']"

# File manager (Super+E)
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

# Configure Dash to Panel if installed
print_info "Configuring Dash to Panel extension settings..."
if gnome-extensions list | grep -q "dash-to-panel"; then
    # Set panel position to bottom
    dconf write /org/gnome/shell/extensions/dash-to-panel/panel-position "'BOTTOM'"
    
    # Set panel size
    dconf write /org/gnome/shell/extensions/dash-to-panel/panel-size 48
    
    # Show applications button
    dconf write /org/gnome/shell/extensions/dash-to-panel/show-apps-icon-file "true"
    
    # Center taskbar items
    dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-margin 4
    
    print_info "Dash to Panel configured for Windows 11-like appearance!"
fi

# Create a configuration summary
print_info "Creating configuration summary..."
cat > ~/Windows11-GNOME-Config.txt << 'EOF'
Windows 11-like GNOME Configuration Applied
==========================================

Theme Settings:
- GTK Theme: WhiteSur-Dark-blue
- Icon Theme: WhiteSur-dark
- Window Buttons: Right-aligned (Windows style)
- Color Scheme: Dark mode

Keyboard Shortcuts (Windows-like):
- Super: Open activities/app menu
- Super+D: Show desktop
- Super+L: Lock screen
- Super+E: Open file manager
- Alt+F4: Close window

Recommended Extensions Installed:
1. Dash to Panel - Windows-like taskbar
2. Arc Menu - Windows 11-style start menu
3. Blur my Shell - Windows 11 blur effects
4. Just Perfection - Shell customization
5. Window Rounded Corners - Rounded window corners

Additional Customization:
- You can further customize the panel in Dash to Panel settings
- Adjust Arc Menu settings for start menu customization
- Configure blur effects in Blur my Shell settings
- Fine-tune appearance in GNOME Tweaks

To revert changes:
- Open GNOME Tweaks and change themes back to default
- Disable extensions in Extensions app
- Reset gsettings: gsettings reset-recursively org.gnome.desktop.wm.preferences
EOF

echo ""
print_info "=== Configuration Complete ==="
echo ""
print_info "Your GNOME desktop has been configured with Windows 11-like appearance!"
echo ""
print_warning "Important: You may need to log out and log back in for all changes to take effect."
echo ""
print_info "Additional steps:"
echo "  1. Open 'Extensions' app to configure installed extensions"
echo "  2. Open 'Tweaks' app to fine-tune appearance"
echo "  3. Right-click on desktop to set a Windows 11-style wallpaper"
echo "  4. Adjust Dash to Panel settings for perfect taskbar appearance"
echo ""
print_info "Configuration summary saved to: ~/Windows11-GNOME-Config.txt"
echo ""

# Restart GNOME Shell (only works on X11, not Wayland)
if [ "$XDG_SESSION_TYPE" == "x11" ]; then
    read -p "Would you like to restart GNOME Shell now? (yes/no): " restart
    if [ "$restart" == "yes" ]; then
        print_warning "Restarting GNOME Shell. Please save your work in all open applications first."
        read -p "Press Enter to continue after saving your work..."
        print_info "Restarting GNOME Shell..."
        killall -SIGQUIT gnome-shell
    fi
else
    print_warning "You're running Wayland. Please log out and log back in to see all changes."
fi

exit 0
