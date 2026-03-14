HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

setopt CORRECT
SPROMPT='zsh: correct %R to %r? [nyae] '

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
                pacman) sudo pacman -S --noconfirm "$@";;
                apt)    sudo apt install -y "$@";;
                dnf)    sudo dnf install -y "$@";;
                zypper) sudo zypper install -y "$@";;
                brew)   brew install "$@";;
            esac
            ;;
        -r)
            shift
            case "$_PM" in
                pacman) sudo pacman -R --noconfirm "$@";;
                apt)    sudo apt remove -y "$@";;
                dnf)    sudo dnf remove -y "$@";;
                zypper) sudo zypper remove -y "$@";;
                brew)   brew uninstall "$@";;
            esac
            ;;
        -u)
            case "$_PM" in
                pacman) sudo pacman -Syu --noconfirm;;
                apt)    sudo apt update && sudo apt upgrade -y;;
                dnf)    sudo dnf upgrade -y;;
                zypper) sudo zypper update -y;;
                brew)   brew update && brew upgrade;;
            esac
            ;;
        -s)
            shift
            case "$_PM" in
                pacman) pacman -Ss "$@";;
                apt)    apt search "$@";;
                dnf)    dnf search "$@";;
                zypper) zypper search "$@";;
                brew)   brew search "$@";;
            esac
            ;;
        -ai)
            shift
            case "$_PM" in
                pacman) yay -S --noconfirm "$@";;
                brew)   brew install --cask "$@";;
                *)      echo "p: -ai is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -ar)
            shift
            case "$_PM" in
                pacman) yay -R --noconfirm "$@";;
                brew)   brew uninstall --cask "$@";;
                *)      echo "p: -ar is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -as)
            shift
            case "$_PM" in
                pacman) yay -Ss "$@";;
                brew)   brew search --cask "$@";;
                *)      echo "p: -as is only available on Arch (yay) or macOS (brew cask).";;
            esac
            ;;
        -fi)
            shift
            if command -v flatpak &>/dev/null; then
                flatpak install "$@"
            else
                echo "p: flatpak is not installed."
            fi
            ;;
        -fr)
            shift
            if command -v flatpak &>/dev/null; then
                flatpak uninstall "$@"
            else
                echo "p: flatpak is not installed."
            fi
            ;;
        -fs)
            shift
            if command -v flatpak &>/dev/null; then
                flatpak search "$@"
            else
                echo "p: flatpak is not installed."
            fi
            ;;
        -h)
            cat <<'EOF'
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
        *) echo "Unknown option: $1. Try 'p -h' for help.";;
    esac
}

fastfetch
