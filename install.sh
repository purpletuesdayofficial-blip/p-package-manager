#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/purpletuesdayofficial-blip/p-package-manager.git"
REPO_DIR="$HOME/.p-package-manager"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.bak"

echo "==> p package manager installer"

if ! command -v git &>/dev/null; then
    echo "Error: git is not installed. Please install it first."
    exit 1
fi

if ! command -v fastfetch &>/dev/null; then
    echo "==> Installing fastfetch..."
    sudo pacman -S fastfetch
fi

if ! command -v zsh &>/dev/null; then
    echo "Warning: zsh doesn't seem to be installed. Continuing anyway..."
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
echo "Done! Thank you for installing my pacman wrapper! And ignore the errors, thats normal!"
echo ""
echo "Quick reference:"
echo "  p -i <pkg>   install"
echo "  p -r <pkg>   remove"
echo "  p -u         update system"
echo "  p -s <pkg>   search"
echo "  p -a <pkg>   install from AUR"
echo "  p -h         help"
source ~/.zshrc
