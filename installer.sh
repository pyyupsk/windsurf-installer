#!/bin/bash

# Script version
VERSION="1.0.0"

# Set error handling
set -euo pipefail
IFS=$'\n\t'

# Variables
WINDSURF_VERSION="1.2.1"
DOWNLOAD_URL="https://windsurf-stable.codeiumdata.com/linux-x64/stable/aa53e9df956d9bc7cb1835f8eaa47768ce0e5b44/Windsurf-linux-x64-${WINDSURF_VERSION}.tar.gz"
ICON_URL="https://codeium.com/logo/windsurf_teal_logo.svg"
INSTALL_DIR="/opt/windsurf"
BIN_DIR="/usr/local/bin"
ICONS_DIR="/usr/share/icons/hicolor/scalable/apps"
APPLICATIONS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

check_dependencies() {
    local missing_deps=()
    
    for cmd in wget tar mkdir rm chmod gtk-update-icon-cache; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        error "Missing required dependencies: ${missing_deps[*]}\nPlease install them using your distribution's package manager."
    fi
}

cleanup() {
    local exit_code=$?
    if [ -d "$TEMP_DIR" ]; then
        log "Cleaning up temporary files..."
        rm -rf "$TEMP_DIR"
    fi
    if [ $exit_code -ne 0 ]; then
        error "Installation failed! Please check the error messages above."
    fi
    exit $exit_code
}

create_dirs() {
    local dirs=("$@")
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            sudo mkdir -p "$dir" || error "Failed to create directory: $dir"
        fi
    done
}

# Print banner
echo "
╭──────────────────────────────────────╮
│     Windsurf IDE Installer $VERSION     │
│        For Linux x64 Systems         │
╰──────────────────────────────────────╯"

# Check for root privileges
if [ "$EUID" -eq 0 ]; then
    error "Please do not run this script as root or with sudo"
fi

# Set up cleanup trap
TEMP_DIR=$(mktemp -d)
trap cleanup EXIT

# Check dependencies
log "Checking dependencies..."
check_dependencies

# Create necessary directories
log "Creating directories..."
create_dirs "$APPLICATIONS_DIR"
sudo mkdir -p "$ICONS_DIR" || error "Failed to create icons directory"

# Download files
log "Downloading Windsurf v${WINDSURF_VERSION}..."
cd "$TEMP_DIR"
wget -q --show-progress "$DOWNLOAD_URL" || error "Failed to download Windsurf"
wget -q --show-progress "$ICON_URL" -O windsurf_icon.svg || error "Failed to download icon"

# Extract archive
log "Extracting files..."
tar xzf "Windsurf-linux-x64-${WINDSURF_VERSION}.tar.gz" || error "Failed to extract archive"

# Install application
log "Installing Windsurf..."
if [ -d "$INSTALL_DIR" ]; then
    log "Removing existing installation..."
    sudo rm -rf "$INSTALL_DIR"
fi

sudo mkdir -p "$INSTALL_DIR"
sudo cp -r Windsurf/* "$INSTALL_DIR/" || error "Failed to copy files"

# Install icon
log "Installing icon..."
sudo cp windsurf_icon.svg "$ICONS_DIR/windsurf.svg" || error "Failed to install icon"

# Create symbolic link
log "Creating symbolic link..."
sudo ln -sf "$INSTALL_DIR/windsurf" "$BIN_DIR/windsurf" || error "Failed to create symbolic link"

# Create desktop entry
log "Creating desktop shortcut..."
cat > "$APPLICATIONS_DIR/windsurf.desktop" << EOL
[Desktop Entry]
Version=1.0
Name=Windsurf
GenericName=IDE
Comment=Windsurf IDE powered by Codeium
Exec=/usr/local/bin/windsurf %F
Icon=windsurf
Terminal=false
Type=Application
Categories=Development;IDE;TextEditor;
Keywords=windsurf;ide;code;editor;
StartupNotify=true
MimeType=text/plain;text/x-chdr;text/x-csrc;text/x-c++hdr;text/x-c++src;text/x-java;text/x-dsrc;text/x-pascal;text/x-perl;text/x-python;application/x-php;application/x-httpd-php3;application/x-httpd-php4;application/x-httpd-php5;application/xml;text/html;text/css;text/x-sql;text/x-diff;
EOL

chmod +x "$APPLICATIONS_DIR/windsurf.desktop" || error "Failed to make desktop entry executable"

# Update icon cache
log "Updating icon cache..."
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    sudo gtk-update-icon-cache -f -t "$ICONS_DIR" || warn "Failed to update icon cache"
fi

log "Installation complete! You can now run 'windsurf' from the terminal or launch it from your applications menu."
log "If the icon doesn't appear immediately, try logging out and back in."