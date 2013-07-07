if [[ $(tty) = "/dev/tty1" ]]; then
#    startxfce4
    startx
    exit
elif [[ -f $HOME/.zshrc ]]; then
    source .zshrc
fi
