#!/bin/bash

# Fixed GUI Manager Script - Prevents Black Screen Issues
# Usage: 
#   bash <(curl -s https://raw.githubusercontent.com/yourusername/gui-manager/main/gui-manager.sh)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Safety Check
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}Error: Do not run this script as root. Use sudo when needed.${NC}"
    exit 1
fi

# Detect OS
if grep -qi "ubuntu" /etc/os-release; then
    OS="Ubuntu"
elif grep -qi "linux mint" /etc/os-release; then
    OS="Mint"
else
    echo -e "${RED}Error: Only Ubuntu and Linux Mint are supported.${NC}"
    exit 1
fi

# Check if running in GUI
check_gui() {
    if [ -n "$DISPLAY" ]; then
        echo -e "${YELLOW}WARNING: You're running this from a GUI terminal.${NC}"
        echo -e "For safety, please:"
        echo -e "1. Press Ctrl+Alt+F3 to switch to a text console"
        echo -e "2. Log in and run this script there"
        echo -e "3. Return to GUI with Ctrl+Alt+F1 (or F2)"
        exit 1
    fi
}

# Force TTY switch if needed
force_tty() {
    echo -e "${YELLOW}>>> Switching to TTY1 to prevent black screen...${NC}"
    sudo chvt 1
    sleep 2
}

# Main removal function
remove_gui() {
    check_gui
    
    echo -e "${YELLOW}>>> Stopping display managers...${NC}"
    sudo systemctl stop gdm3 lightdm sddm 2>/dev/null || true
    sudo pkill -9 "gdm3|lightdm|sddm" 2>/dev/null || true
    
    echo -e "${YELLOW}>>> Removing GUI packages...${NC}"
    if [ "$OS" = "Ubuntu" ]; then
        sudo apt purge -y ubuntu-desktop gnome-shell gdm3 xorg* libwayland*
    else
        sudo apt purge -y cinnamon* mint-meta-cinnamon lightdm xorg*
    fi
    
    sudo apt autoremove --purge -y
    sudo apt clean
    
    echo -e "${GREEN}GUI removed successfully!${NC}"
    echo -e "The system will now reboot into text mode."
    sudo systemctl set-default multi-user.target
    sleep 3
    sudo reboot
}

# [Rest of the script remains the same...]

# Menu
while true; do
    clear
    echo -e "${YELLOW}===== SAFE GUI MANAGER (${OS}) =====${NC}"
    echo "1) Remove GUI completely (SAFE MODE)"
    echo "2) Install default GUI"
    echo "3) Reboot system"
    echo "4) Quit"
    read -p "Choose an option (1-4): " choice

    case $choice in
        1) remove_gui ;;
        2) install_gui ;;
        3) sudo reboot ;;
        4) exit 0 ;;
        *) echo -e "${RED}Invalid option.${NC}"; sleep 1 ;;
    esac
done