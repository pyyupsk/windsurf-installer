#!/bin/bash

# Test script version
SCRIPT_VERSION="1.1.0"

# Variables
WINDSURF_VERSION="1.4.6"
DOWNLOAD_URL="https://windsurf-stable.codeiumdata.com/linux-x64/stable/724a915b3b4c73cea3d2c93fc85672d6aa3961e0/Windsurf-linux-x64-${WINDSURF_VERSION}.tar.gz"
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

# Test results counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

log_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

# Test functions
test_dependencies() {
    log_info "Testing required dependencies..."
    local deps=(wget tar gtk-update-icon-cache)
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" >/dev/null 2>&1; then
            log_pass "Found dependency: $dep"
        else
            log_fail "Missing dependency: $dep"
        fi
    done
}

test_permissions() {
    log_info "Testing user permissions..."
    
    # Test write permission to applications directory
    local app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
    if [ -w "$HOME" ] && mkdir -p "$app_dir" 2>/dev/null; then
        log_pass "User has write permission to applications directory"
    else
        log_fail "User lacks write permission to applications directory"
    fi

    # Test sudo access
    if sudo -v 2>/dev/null; then
        log_pass "User has sudo privileges"
    else
        log_fail "User lacks sudo privileges"
    fi
    
    # Test if user is not root
    if [ "$EUID" -ne 0 ]; then
        log_pass "User is not running as root (as required)"
    else
        log_fail "User is running as root (installer requires non-root)"
    fi
}

test_disk_space() {
    log_info "Testing available disk space..."
    
    # Check for at least 500MB free in /opt and /usr/local
    local required_space=500000
    local available_space_opt
    local available_space_usr

    available_space_opt=$(df /opt | awk 'NR==2 {print $4}')
    available_space_usr=$(df /usr/local | awk 'NR==2 {print $4}')
    
    if [ "$available_space_opt" -gt "$required_space" ]; then
        log_pass "Sufficient disk space available in /opt"
    else
        log_fail "Insufficient disk space in /opt"
    fi
    
    if [ "$available_space_usr" -gt "$required_space" ]; then
        log_pass "Sufficient disk space available in /usr/local"
    else
        log_fail "Insufficient disk space in /usr/local"
    fi
}

test_network() {
    log_info "Testing network connectivity..."
    
    # Test connection to download URLs
    local urls=(
        "${DOWNLOAD_URL}"
        "${ICON_URL}"
        "https://codeium.com"
    )
    
    for url in "${urls[@]}"; do
        if wget -q --spider "$url"; then
            log_pass "Can connect to $url"
        else
            log_fail "Cannot connect to $url"
        fi
    done
}

test_temp_directory() {
    log_info "Testing temporary directory creation..."
    
    local temp_dir
    temp_dir=$(mktemp -d)
    
    if [ -d "$temp_dir" ]; then
        log_pass "Successfully created temporary directory"
        
        # Test write permissions in temp dir
        if touch "$temp_dir/test_file" 2>/dev/null; then
            log_pass "Can write to temporary directory"
            rm "$temp_dir/test_file"
        else
            log_fail "Cannot write to temporary directory"
        fi
        
        # Clean up
        rmdir "$temp_dir"
    else
        log_fail "Failed to create temporary directory"
    fi
}

test_installation() {
    log_info "Testing installation script..."
    
    # Test script existence
    if [ -f "scripts/installer.sh" ]; then
        log_pass "Installation script found"
        
        # Test script permissions
        if [ -x "scripts/installer.sh" ]; then
            log_pass "Installation script is executable"
        else
            log_fail "Installation script is not executable"
        fi
        
        # Test script syntax
        if bash -n scripts/installer.sh; then
            log_pass "Installation script syntax is valid"
        else
            log_fail "Installation script has syntax errors"
        fi
    else
        log_fail "Installation script not found"
    fi
}

test_post_install() {
    log_info "Testing post-installation state..."
    local files=(
        "$INSTALL_DIR"
        "$BIN_DIR/windsurf"
        "$ICONS_DIR/windsurf.svg"
        "$APPLICATIONS_DIR/windsurf.desktop"
    )
    
    for file in "${files[@]}"; do
        if [ -e "$file" ]; then
            log_pass "Found installed file: $file"
        else
            log_fail "Missing installed file: $file"
        fi
    done
    
    # Test command availability
    if command -v windsurf >/dev/null 2>&1; then
        log_pass "Windsurf command is available in PATH"
    else
        log_fail "Windsurf command is not available in PATH"
    fi
    
    # Test desktop file validity
    if [ -f "$APPLICATIONS_DIR/windsurf.desktop" ]; then
        if grep -q "Exec=/usr/local/bin/windsurf" "$APPLICATIONS_DIR/windsurf.desktop" && 
           grep -q "Icon=windsurf" "$APPLICATIONS_DIR/windsurf.desktop"; then
            log_pass "Desktop file appears valid"
        else
            log_fail "Desktop file content is incorrect"
        fi
    fi
    
    # Test icon cache update
    if command -v gtk-update-icon-cache >/dev/null 2>&1; then
        log_pass "Icon cache utility found"
    else
        log_fail "Icon cache utility missing"
    fi
}

# Print banner
echo "
╭──────────────────────────────────────╮
│   Windsurf Installer Test v$SCRIPT_VERSION     │
│        For Linux x64 Systems         │
╰──────────────────────────────────────╯"

# Run tests
test_dependencies
test_permissions
test_disk_space
test_network
test_temp_directory
test_installation
test_post_install

# Print summary
echo "
╭──────────────────────────────────────╮
│            Test Summary              │
├──────────────────────────────────────┤
│ Tests Passed: $TESTS_PASSED                     │
│ Tests Failed: $TESTS_FAILED                      │
╰──────────────────────────────────────╯"

# Exit with appropriate status code
[ "$TESTS_FAILED" -eq 0 ] || exit 1