#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/purpletuesdayofficial-blip/p-package-manager.git"
REPO_DIR="$HOME/.p-package-manager"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.bak"

echo "==> p package manager installer"

# Check for git
if ! command -v git &>/dev/null; then
    echo "Error: git is not installed. Please install it first."
    exit 1
fi

# Check for zsh
if ! command -v zsh &>/dev/null; then
    echo "Warning: zsh doesn't seem to be installed. Continuing anyway..."
fi

# Clone or update the repo
if [ -d "$REPO_DIR/.git" ]; then
    echo "==> Found existing install at $REPO_DIR, pulling latest..."
    git -C "$REPO_DIR" pull
else
    echo "==> Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Back up existing .zshrc if it exists
if [ -f "$ZSHRC" ]; then
    echo "==> Backing up existing .zshrc to $BACKUP"
    cp "$ZSHRC" "$BACKUP"
fi

# Check that the repo contains a .zshrc
if [ ! -f "$REPO_DIR/.zshrc" ]; then
    echo "Error: No .zshrc found in the repository. Aborting."
    exit 1
fi

# Replace .zshrc
echo "==> Installing new .zshrc..."
cp "$REPO_DIR/.zshrc" "$ZSHRC"

echo ""
echo "Done! Restart your terminal or run: source ~/.zshrc"
echo ""
echo "Quick reference:"
echo "  p -i <pkg>   install"
echo "  p -r <pkg>   remove"
echo "  p -u         update system"
echo "  p -s <pkg>   search"
echo "  p -a <pkg>   install from AUR"
echo "  p -h         help"
