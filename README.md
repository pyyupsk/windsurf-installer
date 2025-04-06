# 🌊 Windsurf Installer

A simple Bash script to **install**, **update**, or **uninstall** the **Windsurf IDE** on Linux.

![Windsurf IDE](https://exafunction.github.io/public/images/windsurf/windsurf-ide-thumbnail.jpg)

## ✨ Features

- 🚀 Install or update the **latest version** of Windsurf IDE
- 🔐 Verifies downloads using **SHA256 checksums**
- 🖥️ Automatically creates desktop integration (icon + launcher)
- 📋 Clean and informative logs: success ✅, errors ❌, and warnings ⚠️

## 🔧 Requirements

Make sure the following tools are installed before running the script:

- Core utilities: `curl`, `tar`, `grep`, `sed`, `mktemp`, `basename`, `dirname`, `cut`
- 🔑 **Root privileges** required for install/uninstall

## 💻 Usage

Install Windsurf IDE:

```bash
curl -fsSL https://pyyupsk.is-a.dev/windsurf | sudo bash
```

View the [install script](https://pyyupsk.is-a.dev/windsurf) for more details.

## 🔄 Installation Flow

1. Fetches the latest Windsurf IDE version from the official API
2. Checks for updates if already installed
3. Downloads and verifies the `.tar.gz` archive (SHA256)
4. Extracts and installs to `/opt/windsurf`
5. Creates:
   - A symlink in `/usr/local/bin`
   - A desktop entry for GUI access

## 🧹 Uninstallation

To completely remove Windsurf IDE:

```bash
curl -fsSL https://pyyupsk.is-a.dev/windsurf | sudo bash -s -- --uninstall
```

This will delete:

- `/opt/windsurf`
- `/usr/local/bin/windsurf`
- `/usr/share/applications/windsurf.desktop`

## 🛠️ Troubleshooting

| Issue                            | Solution                                                                                                      |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Missing dependencies**         | Script will notify you. Install missing tools with your package manager (e.g., `apt`, `dnf`, `yum`, `pacman`) |
| **Checksum verification failed** | Retry after checking your internet connection                                                                 |
| **Desktop entry missing**        | Ensure `update-desktop-database` is installed or check installation dir manually                              |
| **Permission errors**            | Run the script with `sudo` for elevated privileges                                                            |

## 🤝 Contributing

We welcome contributions!

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Open a pull request with a clear description

> Please follow existing code style and keep your changes focused.

## 💖 Credits

- Windsurf IDE is developed by [**Codeium**](https://codeium.com).
- This installer is **unofficial** and created by [**@pyyupsk**](https://github.com/pyyupsk) to streamline Linux installation and management.

## ⚠️ Disclaimer

**This installation script for Windsurf IDE is not officially associated with, endorsed by, or affiliated with Codeium (https://codeium.com), the original developers of Windsurf IDE.** This script is provided as an independent, third-party tool to facilitate installation of the software.

The script is provided **"as is" without warranty of any kind**, either expressed or implied, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose. **The entire risk as to the quality and performance of the script is with you.**

By using this installation script, you acknowledge that you are using an **unofficial installation method** and accept all associated risks. Please visit https://codeium.com for official downloads and installation methods.
