# GUI Manager for Ubuntu & Linux Mint

![OS Support](https://img.shields.io/badge/OS-Ubuntu%20|%20Mint-orange?style=for-the-badge&logo=ubuntu)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

A universal shell script to **remove or restore the GUI** on Ubuntu and Linux Mint.  
Supports full GUI removal, restoring default desktops, minimal desktops, and GUI-on-demand mode.

---

## Supported OS

- ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) GNOME, KDE, Xfce, MATE  
- ![Linux Mint](https://img.shields.io/badge/Linux_Mint-87CF3E?style=for-the-badge&logo=linuxmint&logoColor=white) Cinnamon, MATE, Xfce  

---

## Features

- Auto-detects OS (Ubuntu or Mint)  
- Remove any desktop environment (full purge)  
- Restore full default GUI for your OS  
- Install lightweight desktops: Xfce or LXQt  
- GUI-on-demand mode (boot into CLI, start GUI manually)  
- Interactive menu for easy management  

---

## Installation & Usage

### Run directly from GitHub

```bash
curl -sL https://raw.githubusercontent.com/script-php/gui-manager/gui-manager.sh | bash
````

### Or download and run manually

```bash
wget https://raw.githubusercontent.com/script-php/gui-manager/gui-manager.sh
chmod +x gui-manager.sh
./gui-manager.sh
```

---

## Menu Options

| Option | Description                                                                                          |
| ------ | ---------------------------------------------------------------------------------------------------- |
| 1      | **Remove GUI completely** – stop display manager and purge all desktop packages, boot into CLI mode  |
| 2      | **Restore FULL default GUI** – Ubuntu: `ubuntu-desktop`; Mint: choose edition (Cinnamon, MATE, Xfce) |
| 3      | **Restore minimal Xfce** – lightweight desktop with `xfce4`                                          |
| 4      | **Restore minimal LXQt** – ultra-light desktop with `lxqt-core`                                      |
| 5      | **Install GUI-on-demand mode** – boot CLI, start GUI manually with `sudo systemctl start lightdm`    |
| 6      | **Exit** – quit the script                                                                           |

---

## Examples

### Remove GUI

```bash
./gui-manager.sh
# Select option 1
```

### Restore Full GUI

```bash
./gui-manager.sh
# Select option 2
```

### Restore Minimal Xfce

```bash
./gui-manager.sh
# Select option 3
```

### GUI-on-Demand Mode

```bash
./gui-manager.sh
# Select option 5
sudo systemctl start lightdm
```

---

## Notes

* Requires root privileges (`sudo`)
* Tested on Ubuntu 20.04, 22.04, 24.04 and Linux Mint 20, 21, 22
* Safe to re-run multiple times

---

## License

MIT License – free to use and modify

---

## Author

Created by **script-php**


