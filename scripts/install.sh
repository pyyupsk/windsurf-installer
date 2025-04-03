#!/usr/bin/env bash

set -e

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# API endpoint for getting latest version information
API_URL="https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest"
INSTALL_DIR="/opt/windsurf"
BIN_DIR="/usr/local/bin"
APP_NAME="windsurf"
DESKTOP_FILE="/usr/share/applications/windsurf.desktop"

# Function to display message with timestamp
log() {
  echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

# Function to display error message
error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Function to display success message
success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function to display warning message
warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if running as root
check_root() {
  if [ "$EUID" -ne 0 ]; then
    error "This script must be run as root"
    exit 1
  fi
}

# Check for required commands
check_dependencies() {
  local missing_deps=()

  for cmd in curl tar grep sed mktemp basename dirname cut; do
    if ! command -v "$cmd" &>/dev/null; then
      missing_deps+=("$cmd")
    fi
  done

  if [ ${#missing_deps[@]} -ne 0 ]; then
    error "Missing required dependencies: ${missing_deps[*]}"
    log "Please install them using your distribution's package manager"
    log "These should be available in the base packages of all major Linux distributions"
    exit 1
  fi
}

# Get value from JSON string using grep and sed
get_json_value() {
  local json="$1"
  local key="$2"

  echo "$json" | grep -o "\"$key\":[^,}]*" | sed -e 's/^"'"$key"'"://' -e 's/^"//' -e 's/"$//' -e 's/^[ \t]*//' -e 's/[ \t]*$//'
}

# Get the latest version information
get_latest_info() {
  log "Fetching latest Windsurf IDE version information..."

  if ! VERSION_INFO=$(curl -s "$API_URL"); then
    error "Failed to fetch version information"
    exit 1
  fi

  # Parse version information using grep and sed
  DOWNLOAD_URL=$(get_json_value "$VERSION_INFO" "url")
  WINDSURF_VERSION=$(get_json_value "$VERSION_INFO" "productVersion")
  WINDSURF_PACKAGE_VERSION=$(get_json_value "$VERSION_INFO" "windsurfVersion")
  SHA256=$(get_json_value "$VERSION_INFO" "sha256hash")

  # Clean up any remaining quotes
  DOWNLOAD_URL=$(echo "$DOWNLOAD_URL" | sed 's/^"//;s/"$//')
  WINDSURF_VERSION=$(echo "$WINDSURF_VERSION" | sed 's/^"//;s/"$//')
  WINDSURF_PACKAGE_VERSION=$(echo "$WINDSURF_PACKAGE_VERSION" | sed 's/^"//;s/"$//')
  SHA256=$(echo "$SHA256" | sed 's/^"//;s/"$//')

  if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" = "null" ]; then
    error "Failed to parse download URL from version information"
    exit 1
  fi

  if [ -z "$SHA256" ] || [ "$SHA256" = "null" ]; then
    error "Failed to parse SHA256 hash from version information"
    exit 1
  fi

  log "Latest version: $WINDSURF_VERSION (Package: $WINDSURF_PACKAGE_VERSION)"
  success "Version information retrieved successfully"
}

# Update Windsurf if already installed
check_for_updates() {
  if [ -f "$INSTALL_DIR/windsurf" ]; then
    log "Existing Windsurf installation detected"

    # Try to get currently installed version
    if [ -f "$INSTALL_DIR/version" ]; then
      CURRENT_VERSION=$(cat "$INSTALL_DIR/version")
      log "Current version: $CURRENT_VERSION"
      log "Latest version: $WINDSURF_VERSION"

      if [ "$CURRENT_VERSION" = "$WINDSURF_VERSION" ]; then
        log "You already have the latest version installed"
        read -p "Do you want to reinstall anyway? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          log "Installation cancelled"
          exit 0
        fi
      fi
    else
      log "Unable to determine current version, will proceed with update"
    fi
  fi
}

# Download Windsurf
download_windsurf() {
  log "Downloading Windsurf IDE v$WINDSURF_VERSION..."

  local temp_dir
  temp_dir=$(mktemp -d)
  local download_file="$temp_dir/windsurf.tar.gz"

  # Download with progress bar and verbose output
  if ! curl -v -# -L -o "$download_file" "$DOWNLOAD_URL" 2>"$temp_dir/curl.log"; then
    error "Failed to download Windsurf"
    log "Curl error log:"
    cat "$temp_dir/curl.log"
    rm -rf "$temp_dir"
    exit 1
  fi

  # Verify checksum if sha256sum is available
  if command -v sha256sum &>/dev/null; then
    log "Verifying download integrity..."
    local computed_sha256
    computed_sha256=$(sha256sum "$download_file" | cut -d' ' -f1)

    if [ "$computed_sha256" != "$SHA256" ]; then
      error "Checksum verification failed"
      error "Expected: $SHA256"
      error "Got: $computed_sha256"
      rm -rf "$temp_dir"
      exit 1
    fi

    success "Download verified successfully"
  else
    warning "sha256sum not available, skipping checksum verification"
  fi

  TEMP_DIR="$temp_dir"
  DOWNLOAD_FILE="$download_file"
}

# Install Windsurf
install_windsurf() {
  local temp_dir="$1"
  local download_file="$2"

  log "Installing Windsurf IDE to $INSTALL_DIR..."

  # Check if download file exists
  if [ ! -f "$download_file" ]; then
    error "Download file not found: $download_file"
    exit 1
  fi

  # Create installation directory if it doesn't exist
  mkdir -p "$INSTALL_DIR"

  # Remove existing installation if present
  if [ -d "$INSTALL_DIR" ] && [ "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ]; then
    log "Removing previous installation..."
    rm -rf "${INSTALL_DIR:?}"/*
  fi

  # Extract the archive
  log "Extracting files..."
  if ! tar -xzf "$download_file" -C "$temp_dir"; then
    error "Failed to extract archive: $download_file"
    exit 1
  fi

  # Find the extracted directory
  local extracted_dir=""

  # First try with find
  if command -v find &>/dev/null; then
    extracted_dir=$(find "$temp_dir" -maxdepth 1 -type d -name "Windsurf-*" -o -name "windsurf-*" | head -n 1)
  fi

  # If find failed or found nothing, try with ls and grep
  if [ -z "$extracted_dir" ]; then
    for dir in "$temp_dir"/*; do
      if [ -d "$dir" ] && [[ "$dir" == *"indsurf"* ]]; then
        extracted_dir="$dir"
        break
      fi
    done
  fi

  if [ -z "$extracted_dir" ]; then
    error "Could not find extracted Windsurf directory"
    rm -rf "$temp_dir"
    exit 1
  fi

  # Copy files to installation directory
  cp -R "$extracted_dir"/* "$INSTALL_DIR/"

  # Set correct permissions
  chmod 755 "$INSTALL_DIR"

  if [ -f "$INSTALL_DIR/windsurf" ]; then
    chmod +x "$INSTALL_DIR/windsurf"
  else
    error "Executable not found in the expected location"
    rm -rf "$temp_dir"
    exit 1
  fi

  success "Windsurf IDE installed successfully"

  # Clean up
  rm -rf "$temp_dir"
}

# Create version file
create_version_file() {
  echo "$WINDSURF_VERSION" >"$INSTALL_DIR/version"
}

# Create desktop integration
create_desktop_integration() {
  log "Creating desktop integration..."

  # Find icon path
  ICON_PATH="$INSTALL_DIR/resources/app/resources/linux/windsurf.png"

  # If primary path doesn't exist, try to find icon using standard tools
  if [ ! -f "$ICON_PATH" ]; then
    # Try alternative paths with simple shell commands
    for pattern in "windsurf.png" "icon.png" "*.png"; do
      # Try with find if available
      if command -v find &>/dev/null; then
        ICON_PATH=$(find "$INSTALL_DIR" -name "$pattern" | head -n 1)
        if [ -n "$ICON_PATH" ]; then
          break
        fi
      else
        # Fallback to recursive search with just shell
        shopt -s globstar nullglob
        for dir in "$INSTALL_DIR"/**/; do
          if [ -d "$dir" ]; then
            for file in "$dir"*; do
              if [[ "$file" == *"$pattern"* ]] && [ -f "$file" ]; then
                ICON_PATH="$file"
                break 3
              fi
            done
          fi
        done
        shopt -u globstar nullglob
      fi
    done

    if [ -z "$ICON_PATH" ] || [ ! -f "$ICON_PATH" ]; then
      warning "Icon not found, using generic icon"
      ICON_PATH="text-editor"
    fi
  fi

  # Create symbolic link in PATH
  if [ -L "$BIN_DIR/$APP_NAME" ]; then
    rm "$BIN_DIR/$APP_NAME"
  fi

  ln -s "$INSTALL_DIR/windsurf" "$BIN_DIR/$APP_NAME"

  mkdir -p "$(dirname "$DESKTOP_FILE")"

  # Create desktop entry
  cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Windsurf IDE
Comment=Universal Code Editor by Codeium
GenericName=Text Editor
Exec=$INSTALL_DIR/windsurf %F
Icon=$ICON_PATH
Type=Application
StartupNotify=true
StartupWMClass=Windsurf
Categories=TextEditor;Development;IDE;
MimeType=text/plain;
Keywords=windsurf;code;editor;development;programming;
EOF

  # Update desktop database if available
  if command -v update-desktop-database &>/dev/null; then
    update-desktop-database
  fi

  success "Desktop integration completed"
}

# Verify installation
verify_installation() {
  log "Verifying installation..."

  if [ ! -f "$INSTALL_DIR/windsurf" ]; then
    error "Installation verification failed: executable not found"
    return 1
  fi

  if [ ! -L "$BIN_DIR/$APP_NAME" ]; then
    warning "Binary symlink not found in $BIN_DIR"
  fi

  if [ ! -f "$DESKTOP_FILE" ]; then
    warning "Desktop file not created"
  fi

  success "Windsurf IDE v$WINDSURF_VERSION has been successfully installed!"
  log "You can start Windsurf IDE by typing 'windsurf' in your terminal or from your application menu"

  return 0
}

# Main installation flow
main() {
  echo "================================================================="
  echo "            Windsurf IDE Installer (Latest Version)              "
  echo "================================================================="

  check_root
  check_dependencies
  get_latest_info
  check_for_updates

  # Ask for confirmation
  read -p "This will install Windsurf IDE v$WINDSURF_VERSION to $INSTALL_DIR. Continue? [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Installation cancelled by user"
    exit 0
  fi

  # Declare global variables to store paths
  TEMP_DIR=""
  DOWNLOAD_FILE=""

  # Perform installation
  download_windsurf

  # Verify installation
  if [ -z "$TEMP_DIR" ] || [ -z "$DOWNLOAD_FILE" ]; then
    error "Failed to download Windsurf"
    exit 1
  fi

  install_windsurf "$TEMP_DIR" "$DOWNLOAD_FILE"
  create_version_file
  create_desktop_integration
  verify_installation

  echo "================================================================="
}

# Run the main function
main
