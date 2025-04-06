# 🌊 Windsurf Installer

A simple Bash script to **install**, **update**, or **uninstall** the **Windsurf IDE** on Linux.

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

### 🔹 Quick Install / Uninstall

**Install / Update:**

```bash
curl -fsSL https://pyyupsk.github.io/windsurf-installer/install.sh | sudo bash
```

### 🔸 Manual Installation

**1. Download the script:**

Option 1: Direct download

```bash
curl -LO https://pyyupsk.github.io/windsurf-installer/install.sh
chmod +x install.sh
```

Option 2: Clone the repo

```bash
git clone https://github.com/pyyupsk/windsurf-installer
cd windsurf-installer/scripts
chmod +x install.sh
```

**2. Run the script:**

```bash
sudo ./install.sh
```

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

**One-liner:**

```bash
curl -fsSL https://pyyupsk.github.io/windsurf-installer/install.sh | sudo bash -s -- --uninstall
```

**Manual:**

```bash
sudo ./install.sh --uninstall
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

This script is provided **"as is"**, without any warranties—express or implied. Use it at your own risk. Always back up your system before running installation scripts.
