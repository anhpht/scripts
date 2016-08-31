if [[ $(tty) = "/dev/tty1" ]]; then
    startxfce4
    exit
elif [[ -f $HOME/.zshrc ]]; then
    source .zshrc
fi
