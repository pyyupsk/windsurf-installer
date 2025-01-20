#!/bin/bash

# Test script version
VERSION="1.0.0"

# Variables
WINDSURF_VERSION="1.2.1"

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
    local deps=(wget tar mkdir rm chmod gtk-update-icon-cache)
    
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
}

test_disk_space() {
    log_info "Testing available disk space..."
    
    # Check for at least 500MB free in /opt
    local required_space=500000
    local available_space

    available_space=$(df /opt | awk 'NR==2 {print $4}')
    
    if [ "$available_space" -gt "$required_space" ]; then
        log_pass "Sufficient disk space available in /opt"
    else
        log_fail "Insufficient disk space in /opt"
    fi
}

test_network() {
    log_info "Testing network connectivity..."
    
    # Test connection to download URLs
    local urls=(
        "https://windsurf-stable.codeiumdata.com/linux-x64/stable/aa53e9df956d9bc7cb1835f8eaa47768ce0e5b44/Windsurf-linux-x64-${WINDSURF_VERSION}.tar.gz"
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

test_installation() {
    log_info "Testing installation script..."
    
    # Test script existence
    if [ -f "installer.sh" ]; then
        log_pass "Installation script found"
        
        # Test script permissions
        if [ -x installer.sh ]; then
            log_pass "Installation script is executable"
        else
            log_fail "Installation script is not executable"
        fi
        
        # Test script syntax
        if bash -n installer.sh; then
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
        "/opt/windsurf"
        "/usr/local/bin/windsurf"
        "/usr/share/icons/hicolor/scalable/apps/windsurf.svg"
        "${XDG_DATA_HOME:-$HOME/.local/share}/applications/windsurf.desktop"
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
}

# Print banner
echo "
╭──────────────────────────────────────╮
│   Windsurf Installer Test v$VERSION     │
│        For Linux x64 Systems         │
╰──────────────────────────────────────╯"

# Run tests
test_dependencies
test_permissions
test_disk_space
test_network
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