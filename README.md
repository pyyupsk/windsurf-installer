# windsurf-installer

A universal installation script for Windsurf IDE on Linux systems. This script provides an easy way to install Windsurf on any Linux distribution, complete with desktop integration and icon support.

## Features

- 🚀 One-command installation of Windsurf IDE
- 🖥️ Full desktop integration (application menu entry, file associations)
- 🎨 Proper icon installation
- 📦 Automatic dependency checking
- 🛡️ Secure installation process
- 🔄 Clean upgrade support
- 💻 Distribution-agnostic design

## Prerequisites

The script requires the following dependencies:

- `wget`
- `tar`
- `gtk-update-icon-cache` (optional, for icon cache updating)

Most Linux distributions come with these tools pre-installed. If any are missing, the script will notify you.

## Installation

To install Windsurf, you can run these commands:

```bash
wget -qO- https://raw.githubusercontent.com/pyyupsk/windsurf-installer/main/scripts/installer.sh | bash

```

The script will handle everything else automatically.

## What Gets Installed

The installer will:

- Install Windsurf to `/opt/windsurf/`
- Create a symbolic link in `/usr/local/bin/`
- Install the application icon to `/usr/share/icons/`
- Create a desktop entry in `~/.local/share/applications/`

## Uninstallation

To uninstall Windsurf, you can run these commands:

```bash
wget -qO- https://raw.githubusercontent.com/pyyupsk/windsurf-installer/main/scripts/uninstall.sh | bash
```

## Troubleshooting

### Icon Not Showing

If the icon doesn't appear immediately after installation:

1. Log out and log back in, or
2. Run: `gtk-update-icon-cache -f -t ~/.local/share/icons`

### Permission Issues

Make sure you're not running the script as root. The script will ask for sudo permissions when needed.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[MIT License](LICENSE) - feel free to use and modify this script for your needs.

## Credits

- Windsurf IDE is developed by [Codeium](https://codeium.com)

## Disclaimer

This is an unofficial installation script and is not affiliated with Codeium. Windsurf IDE is a trademark of Codeium.
