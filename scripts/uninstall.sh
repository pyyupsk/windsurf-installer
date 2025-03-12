#!/bin/bash

# Windsurf Cleanup Script
SCRIPT_VERSION="1.1.0"

# Variables (matching those in the installer)
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

# Print banner
echo "
╭──────────────────────────────────────╮
│     Windsurf Cleanup v$SCRIPT_VERSION         │
│        For Linux x64 Systems         │
╰──────────────────────────────────────╯"

# Check for root privileges
if [ "$EUID" -eq 0 ]; then
    error "Please do not run this script as root or with sudo"
fi

# Confirm cleanup
echo -e "${YELLOW}This script will remove all Windsurf files from your system.${NC}"
read -p "Do you want to continue? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Cleanup cancelled."
    exit 0
fi

# Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    log "Removing Windsurf installation directory..."
    sudo rm -rf "$INSTALL_DIR" || warn "Failed to remove $INSTALL_DIR"
else
    log "Installation directory not found."
fi

# Remove symbolic link
if [ -L "$BIN_DIR/windsurf" ]; then
    log "Removing symbolic link..."
    sudo rm -f "$BIN_DIR/windsurf" || warn "Failed to remove symbolic link"
else
    log "Symbolic link not found."
fi

# Remove icon
if [ -f "$ICONS_DIR/windsurf.svg" ]; then
    log "Removing icon..."
    sudo rm -f "$ICONS_DIR/windsurf.svg" || warn "Failed to remove icon"
else
    log "Icon file not found."
fi

# Remove desktop entry
if [ -f "$APPLICATIONS_DIR/windsurf.desktop" ]; then
    log "Removing desktop entry..."
    rm -f "$APPLICATIONS_DIR/windsurf.desktop" || warn "Failed to remove desktop entry"
else
    log "Desktop entry not found."
fi

# Update icon cache
log "Updating icon cache..."
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    sudo gtk-update-icon-cache -f -t "$ICONS_DIR" 2>/dev/null || warn "Failed to update icon cache"
fi

# Remove any temporary files that might have been left behind
log "Cleaning up any temporary files..."
tmp_files=$(find /tmp -name "Windsurf-linux-x64-*" 2>/dev/null)
if [ -n "$tmp_files" ]; then
    rm -rf "$tmp_files" || warn "Failed to remove temporary files"
fi

log "Cleanup complete! Windsurf has been removed from your system."