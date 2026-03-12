HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

setopt CORRECT
SPROMPT='zsh: correct %R to %r? [nyae] '

# ~/.zshrc
p() {
    case "$1" in
        -i) shift; sudo pacman --noconfirm -S "$@";;
        -r) shift; sudo pacman --noconfirm -R "$@";;
        -u) shift; sudo pacman --noconfirm -Syu;;
        -s) shift; pacman --noconfirm -Ss "$@";;
        -a) shift; yay --noconfirm -S "$@";;
        -h)
            cat <<'EOF'
Usage: p [option] [package-name]

Options:
  -i    Install package(s)           → pacman -S
  -r    Remove package(s)            → pacman -R
  -u    Update system                → pacman -Syu
  -s    Search for package(s)        → pacman -Ss
  -a    Install from AUR             → yay -S
  -h    Show help               → help
EOF
        ;;
        *) echo "Unknown option: $1. Try 'p -h' for help.";;
    esac
}
