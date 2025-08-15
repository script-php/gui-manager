#!/bin/bash
# GUI Remove/Restore Script for Ubuntu & Linux Mint
# Author: script-php
# Version: 1.0

set -e

# Detect OS
if grep -qi "Ubuntu" /etc/os-release; then
    OS="Ubuntu"
elif grep -qi "Linux Mint" /etc/os-release; then
    OS="Mint"
else
    echo "Unsupported OS. This script works on Ubuntu and Linux Mint only."
    exit 1
fi

echo "Detected OS: $OS"

# Function: remove GUI
remove_gui() {
    echo "Stopping display manager..."
    if systemctl list-unit-files | grep -q gdm3; then
        sudo systemctl stop gdm3
        sudo systemctl disable gdm3
    elif systemctl list-unit-files | grep -q lightdm; then
        sudo systemctl stop lightdm
        sudo systemctl disable lightdm
    elif systemctl list-unit-files | grep -q sddm; then
        sudo systemctl stop sddm
        sudo systemctl disable sddm
    fi

    echo "Removing desktop environment..."
    if [ "$OS" == "Ubuntu" ]; then
        sudo apt purge -y ubuntu-desktop kubuntu-desktop xubuntu-desktop ubuntu-mate-desktop gnome-shell kde-plasma-desktop xfce4* mate* lxqt* xorg* xserver-xorg* x11-common libx11* libwayland*
    elif [ "$OS" == "Mint" ]; then
        sudo apt purge -y cinnamon* nemo* mint-meta-cinnamon mate* mint-meta-mate xfce4* mint-meta-xfce lightdm slick-greeter xorg* xserver-xorg* x11-common libx11* libwayland*
    fi
    sudo apt autoremove --purge -y
    sudo apt clean
    sudo systemctl set-default multi-user.target
    echo "GUI removed. System will now boot in CLI mode."
}

# Function: restore full GUI
restore_full_gui() {
    if [ "$OS" == "Ubuntu" ]; then
        sudo apt install -y ubuntu-desktop gdm3
        sudo systemctl enable gdm3
    elif [ "$OS" == "Mint" ]; then
        echo "Choose Mint edition to restore:"
        echo "1) Cinnamon"
        echo "2) MATE"
        echo "3) Xfce"
        read -p "Enter choice: " mint_choice
        case $mint_choice in
            1) sudo apt install -y mint-meta-cinnamon lightdm slick-greeter ;;
            2) sudo apt install -y mint-meta-mate lightdm slick-greeter ;;
            3) sudo apt install -y mint-meta-xfce lightdm slick-greeter ;;
            *) echo "Invalid choice"; return ;;
        esac
        sudo systemctl enable lightdm
    fi
    sudo systemctl set-default graphical.target
    echo "Full GUI restored."
}

# Function: restore minimal Xfce
restore_minimal_xfce() {
    sudo apt install -y --no-install-recommends xfce4 lightdm
    if [ "$OS" == "Mint" ]; then
        sudo apt install -y slick-greeter
    fi
    sudo systemctl enable lightdm
    sudo systemctl set-default graphical.target
    echo "Minimal Xfce restored."
}

# Function: restore minimal LXQt
restore_minimal_lxqt() {
    sudo apt install -y --no-install-recommends lxqt-core lightdm
    if [ "$OS" == "Mint" ]; then
        sudo apt install -y slick-greeter
    fi
    sudo systemctl enable lightdm
    sudo systemctl set-default graphical.target
    echo "Minimal LXQt restored."
}

# Function: GUI on demand
gui_on_demand() {
    restore_minimal_xfce
    sudo systemctl set-default multi-user.target
    echo "GUI will only start manually with: sudo systemctl start lightdm"
}

# Menu
while true; do
    echo ""
    echo "===== GUI Management Menu ====="
    echo "1) Remove GUI completely"
    echo "2) Restore FULL default GUI"
    echo "3) Restore minimal Xfce"
    echo "4) Restore minimal LXQt"
    echo "5) Install GUI-on-demand mode"
    echo "6) Exit"
    read -p "Select an option: " choice
    case $choice in
        1) remove_gui ;;
        2) restore_full_gui ;;
        3) restore_minimal_xfce ;;
        4) restore_minimal_lxqt ;;
        5) gui_on_demand ;;
        6) exit 0 ;;
        *) echo "Invalid choice, try again." ;;
    esac
done
