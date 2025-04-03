# Windsurf Installer 🚀

A simple Bash script to **install**, **update**, and **uninstall** the **Windsurf IDE** on Linux.

**Before you begin, you must download the script or clone the repository to your local machine.**

## Features 🎉

- Install or update the latest version of Windsurf IDE.
- Verify downloads with SHA256 checksum for security.
- Auto-create desktop integration for easy access.
- Minimal and clear logs for success, errors, and warnings.

## Requirements 🛠️

Before running the script, ensure you have the following tools installed:

- `curl`, `tar`, `grep`, `sed`, `mktemp`, `basename`, `dirname`, `cut`
- Optional: `sha256sum` (for checksum verification)
- Root privileges are required to install/uninstall.

## Usage 💻

**1. Download the script or clone the repository:**

**Option 1: Download the script directly:**

```bash
curl -LO https://raw.githubusercontent.com/pyyupsk/windsurf-installer/refs/heads/main/scripts/install.sh
chmod +x install.sh
```

**Option 2: Clone the repository (if applicable):**

```bash
git clone https://github.com/pyyupsk/windsurf-installer
cd windsurf-installer/scripts
```

**2. Make the script executable:**

```bash
chmod +x install.sh
```

**3. Run the script:**

### Install or Update

To install or update Windsurf IDE:

```bash
sudo ./install.sh
```

### Uninstall

To remove the Windsurf IDE:

```bash
sudo ./install.sh --uninstall
```

### Help

To view usage information:

```bash
./install.sh --help
```

## Installation Flow 🔄

1. The script fetches the latest version of Windsurf IDE from the official API.
2. It checks if any updates are needed for your existing installation.
3. The script downloads the `.tar.gz` archive and verifies the checksum.
4. It extracts the files and installs them to `/opt/windsurf`.
5. The script creates a symbolic link and desktop entry for easy access.

## Uninstallation 🧹

To remove the IDE completely, run:

```bash
sudo ./install.sh --uninstall
```

This will remove:

- The installation directory (`/opt/windsurf`).
- The symlink (`/usr/local/bin/windsurf`).
- The desktop entry (`/usr/share/applications/windsurf.desktop`).

## Troubleshooting 🛠️

- **Missing dependencies**: If the script can't find required tools, it will notify you. Install them using your package manager (e.g., `apt`, `yum`, `dnf`).
- **Checksum verification failure**: If the downloaded file doesn't match the expected checksum, the installation will fail to protect against corrupted files. Ensure a stable internet connection and retry.

- **Desktop entry not created**: If the script fails to create a desktop entry, it will fall back to a generic icon. Make sure you have `update-desktop-database` installed, or manually check the installation directory for the desktop entry.

- **Permissions issues**: The script needs root privileges for installation and uninstallation. If you encounter permission errors, ensure you're running the script with `sudo`.

## Contributing 🤝

Contributions are welcome! If you find any bugs or have ideas for improvements, feel free to:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Open a pull request with a description of what you've done.

Please ensure that your code follows the style and conventions used in the project.

## Credits 💖

- **[Codeium](https://codeium.com)** is the developer of **Windsurf IDE**. This script is **unofficial** and created by **[pyyupsk](https://github.com/pyyupsk)** to simplify the installation and management of Windsurf IDE on Linux.

## Disclaimer ⚠️

This script is provided "as is", without warranty of any kind, either express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, or non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software. Always back up your data before running scripts on your system.
