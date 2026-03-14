#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/purpletuesdayofficial-blip/p-package-manager.git"
REPO_DIR="$HOME/.p-package-manager"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.bak"
 if command -v pacman &>/dev/null; then
        _PM="pacman"
    elif command -v apt &>/dev/null; then
        _PM="apt"
    elif command -v dnf &>/dev/null; then
        _PM="dnf"
    elif command -v zypper &>/dev/null; then
        _PM="zypper"
    elif command -v brew &>/dev/null; then
        _PM="brew"
    else
        echo "p: no supported package manager found."
        return 1
    fi

echo "==> p package manager installer"

if ! command -v git &>/dev/null; then
    echo "Error: git is not installed. Please install it first."
    exit 1
fi

if ! command -v fastfetch &>/dev/null; then
    echo "==> Installing requirements..."
    if ["$_PM" = "pacman"]; then
        sudo pacman -S fastfetch zsh flatpak 
    fi
    if ["$_PM" = "apt"]; then
        sudo apt install fastfetch zsh
    fi
    if ["$_PM" = "dnf"]; then
        sudo dnf install fastfetch zsh
    fi
    if ["$_PM" = "zypper"]; then
        sudo zypper install fastfetch zsh
    fi
    if ["$_PM" = "brew"]; then
        brew install fastfetch zsh
    fi
    
fi
if [ -d "$REPO_DIR/.git" ]; then
    echo "==> Found existing install at $REPO_DIR, pulling latest..."
    git -C "$REPO_DIR" pull
else
    echo "==> Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

if [ -f "$ZSHRC" ]; then
    echo "==> Backing up existing .zshrc to $BACKUP"
    cp "$ZSHRC" "$BACKUP"
fi

if [ ! -f "$REPO_DIR/.zshrc" ]; then
    echo "Error: No .zshrc found in the repository. Aborting."
    exit 1
fi

echo "==> Installing new .zshrc..."
cp "$REPO_DIR/.zshrc" "$ZSHRC"

echo "==> Modifying permissions..."
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman" | sudo tee /etc/sudoers.d/p-package-manager
sudo chmod 440 /etc/sudoers.d/p-package-manager

echo ""
echo "Done! Thank you for installing my wrapper! And ignore the errors, thats normal!"
echo ""
echo "Quick reference:"
echo "  p -i <pkg>   install"
echo "  p -r <pkg>   remove"
echo "  p -u         update system"
echo "  p -s <pkg>   search"
echo "  p -ai <pkg>  install from AUR/cask if available"
echo "  p -ar <pkg>  remove from AUR/cask if available"
echo "  p -as <pkg>  search the AUR/cask if available"
echo "  p -fi <flatpak> install from Flatpak"
echo "  p -fr <flatpak> remove from Flatpak"
echo "  p -fs <flatpak> search Flatpak"
echo "  p -h         help"
source ~/.zshrc
