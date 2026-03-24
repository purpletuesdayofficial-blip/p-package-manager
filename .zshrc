HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

setopt CORRECT
SPROMPT='zsh: correct %R to %r? [nyae] '
ascii() {
	echo -e "\e[34m███████████████████████                     ████████████████████████████████████
████████████████████████              ██████████████████████████████████████████████
████████████████████████           █████████████████████████████████████████████████████
████████████████████████        ███████████████████████████████████████████████████████████
████████████████████████      ███████████████████████████████████████████████████████████████
█████████████████████████   ███████████████████████████████████████████████████████████████████
█████████████████████████  █████████████████████████████████████████████████████████████████████
█████████████████████████████████████████████████████████████████████████████████████████████████
██████████████████████████████████████████████████████████████████████████████████████████████████
████████████████████████████████████████████                ███████████████████████████████████████
█████████████████████████████████                                  █████████████████████████████████
█████████████████████████████                                          █████████████████████████████
███████████████████████████                                              ███████████████████████████
██████████████████████████                                               ███████████████████████████
█████████████████████████                                                 ██████████████████████████
██████████████████████████                                               ███████████████████████████
███████████████████████████                                             ████████████████████████████
██████████████████████████████                                        ██████████████████████████████
███████████████████████████████████                               ██████████████████████████████████
███████████████████████████████████████████████████████████████████████████████████████████████████
██████████████████████████████████████████████████████████████████████████████████████████████████
█████████████████████████ ███████████████████████████████████████████████████████████████████████
█████████████████████████  █████████████████████████████████████████████████████████████████████
█████████████████████████   ██████████████████████████████████████████████████████████████████
█████████████████████████      █████████████████████████████████████████████████████████████
█████████████████████████        █████████████████████████████████████████████████████████
█████████████████████████           ███████████████████████████████████████████████████
█████████████████████████               ████████████████████████████████████████████
█████████████████████████                    █████████████████████████████████
█████████████████████████                                 ███████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████
█████████████████████████\e[0m"
}
# ~/.zshrc
p() {
    # detect native package manager
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

    case "$1" in
        -i)
            shift
            case "$_PM" in
                pacman) ascii && sudo pacman -S --noconfirm "$@";;
                apt)    ascii && sudo apt install -y "$@";;
                dnf)    ascii && sudo dnf install -y "$@";;
                zypper) ascii && sudo zypper install -y "$@";;
                brew)   ascii && brew install "$@";;
            esac
            ;;
        -r)
            shift
            case "$_PM" in
                pacman) ascii && sudo pacman -R --noconfirm "$@";;
                apt)    ascii && sudo apt remove -y "$@";;
                dnf)    ascii && sudo dnf remove -y "$@";;
                zypper) ascii && sudo zypper remove -y "$@";;
                brew)   ascii && brew uninstall "$@";;
            esac
            ;;
        -u)
            case "$_PM" in
                pacman) ascii && sudo pacman -Syu --noconfirm;;
                apt)    ascii && sudo apt update && sudo apt upgrade -y;;
                dnf)    ascii && sudo dnf upgrade -y;;
                zypper) ascii && sudo zypper update -y;;
                brew)   ascii && brew update && brew upgrade;;
            esac
            ;;
        -s)
            shift
            case "$_PM" in
                pacman) ascii && pacman -Ss "$@";;
                apt)    ascii && apt search "$@";;
                dnf)    ascii && dnf search "$@";;
                zypper) ascii && zypper search "$@";;
                brew)   ascii && brew search "$@";;
            esac
            ;;
        -ai)
            shift
            case "$_PM" in
                pacman) ascii && yay -S --noconfirm "$@";;
                brew)   ascii && brew install --cask "$@";;
                *)      ascii && echo "p: -ai is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -ar)
            shift
            case "$_PM" in
                pacman) ascii && yay -R --noconfirm "$@";;
                brew)   ascii && brew uninstall --cask "$@";;
                *)      ascii && echo "p: -ar is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -as)
            shift
            case "$_PM" in
                pacman) ascii && yay -Ss "$@";;
                brew)   ascii && brew search --cask "$@";;
                *)      ascii && echo "p: -as is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -fi)
            shift
            if command -v flatpak &>/dev/null; then
                ascii && flatpak install "$@"
            else
                ascii && echo "p: flatpak is not installed."
            fi
            ;;
        -fr)
            shift
            if command -v flatpak &>/dev/null; then
                ascii && flatpak uninstall "$@"
            else
                ascii && echo "p: flatpak is not installed."
            fi
            ;;
        -fs)
            shift
            if command -v flatpak &>/dev/null; then
                ascii && flatpak search "$@"
            else
                ascii && echo "p: flatpak is not installed."
            fi
            ;;
        -h)
            ascii && cat <<'EOF'
Usage: p [option] [package-name]

Options:
  -i     Install package(s)
  -r     Remove package(s)
  -u     Update system
  -s     Search for package(s)

  -ai    Install from AUR (Arch) or Cask (macOS)
  -ar    Remove AUR package (Arch) or Cask app (macOS)
  -as    Search AUR (Arch) or Cask (macOS)

  -fi    Install a Flatpak
  -fr    Remove a Flatpak
  -fs    Search Flatpak

  -h     Show this help
EOF
            ;;
        *) ascii && echo "Unknown option: $1. Try 'p -h' for help.";;
    esac
}

fastfetch
