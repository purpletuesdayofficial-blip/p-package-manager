# p — Package Manager Wrapper for Arch Linux

`p` is a minimal zsh function that wraps `pacman` and `yay` into a single, fast command. No more typing `sudo pacman -S` or forgetting flags — just `p`.

---

## What's new?

- Added support for apt/Debian, dnf/RHEL, zypper/openSUSE, and homebrew/MacOS systems.

---

## Features

- Install, remove, update, and search packages with one-letter flags
- AUR support via `yay`
- Zero dependencies beyond `pacman` and optionally `yay`
- Lives entirely in your `.zshrc` — no binaries, no PATH pollution
- Requires 0 confirmation, but do be careful!
- It also removes ANY password authentication for pacman for ALL users, you have been warned, dont sue me please

---

## Requirements

- Arch Linux (or any Arch-based distro: Manjaro, EndeavourOS, CachyOS, etc.)
- `zsh` as your shell
- `pacman` (comes with Arch)
- `yay` — only required for `-a` (AUR installs)

---

## Installation

### Automatic (recommended)

```bash
bash <(curl -s https://raw.githubusercontent.com/purpletuesdayofficial-blip/p-package-manager/main/install.sh)
```

Or clone and run manually:

```bash
git clone https://github.com/purpletuesdayofficial-blip/p-package-manager.git
cd p-package-manager
bash install.sh
```

The installer will back up your existing `.zshrc` and replace it with the one from this repo.

### Manual

Copy the `p()` function from `.zshrc` into your own `~/.zshrc`, then run:

```bash
source ~/.zshrc
```

---

## Usage

```
p [option] [package-name]
```

| Flag | Description              | Equivalent command                                                                                                                            |
|------|--------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| `-i` | Install package(s)       | `sudo pacman -S`, `sudo apt install`, `sudo zypper install`, `sudo dnf install`, or `brew install`                                            |
| `-r` | Remove package(s)        | `sudo pacman -R`, `sudo apt purge`, `sudo zypper remove`, `sudo dnf remove`, or `brew remove`                                                 |
| `-u` | Update system            | `sudo pacman -Syu`, `sudo apt update && sudo apt upgrade`, `sudo zypper update`,  `sudo dnf upgrade -y`, or `brew update && brew upgrade`     |
| `-s` | Search for package(s)    | `pacman -Ss`, `apt search`, `dnf search`, `zypper search`, `brew search`                                                                      |                        
| `-ai`| Install from AUR/cask on supported systems      | `yay -S`, `brew install --cask`                                                                                        |
| `-ar`| Remove from AUR/cask on supported systems       | `yay -R`, `brew remove --cask`                                                                                         |
| `-as`| Search the AUR/cask on supported systems        | `yay -Ss`, `brew search --cask`                                                                                        |  
| `-fi`| Install from Flatpak     | `flatpak install`                                                                                                                             |
| `-fr`| Remove from Flatpak      | `flatpak remove`                                                                                                                              |
| `-fs`| Search on Flatpak        | `flatpak search`                                                                                                                              |  
| `-h` | Show help                | —                                                                                                                                             |

---

## Examples

```bash
p -i neovim            # Install neovim
p -r firefox           # Remove firefox
p -u                   # Full system update
p -s htop              # Search for htop
p -a vesktop           # Install vesktop from AUR
p -h                   # Show help
```

---

## Notes

- `-u` ignores any additional arguments (it always runs a full system upgrade)
- `-a` requires `yay` to be installed. Install it with:
  ```bash
  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
  ```
- Unknown flags will print a short error pointing to `p -h`

---

## License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

You are free to use, modify, and distribute this software, provided that any derivative works are also licensed under the GPL v3. There is no warranty.
