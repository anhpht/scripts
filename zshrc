autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz zmv
autoload -U  zargs
autoload -U  age

zmodload zsh/files
zmodload zsh/complist

limit -s coredumpsize 0
umask    0027
source   /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source   zsh/functions

setopt   alwaystoend
setopt   autocd
setopt   autopushd
setopt   autoresume
setopt   bashautolist
setopt   cdablevars
setopt   correctall
setopt   extendedglob
setopt   extendedhistory
setopt   globdots
setopt   histexpiredupsfirst
setopt   histfindnodups
setopt   histignoredups
setopt   histreduceblanks
setopt   histsavenodups
setopt   incappendhistory
setopt   interactive
setopt   longlistjobs
setopt   mailwarning
#setopt   menucomplete
setopt   noautoparamslash
setopt   nobeep
setopt   nobgnice
setopt   nohup
setopt   numericglobsort
setopt   promptsubst
setopt   pushdminus
setopt   pushdsilent
setopt   pushdtohome
setopt   rcquotes
setopt   recexact
setopt   sharehistory
setopt   shwordsplit

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
DIRSTACKSIZE=20
fignore=(.o .c~)

# ---[ Environment ]---------------------------------------------------
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.flv=01;35:*.mp4=01;35:*.mkv=01;35:*.xcf=01;35:*.VOB=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
export SHELL=zsh
export EDITOR=vim
export MANPAGER='/usr/bin/most -s'
export LANG=en_US.UTF-8
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export MANSECT=3:2:9:8:1:5:4:7:6:n
export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
export CSCOPE_DB=/home/fta/cscope/oam/cscope.out

PATH='/usr/bin'
PATH=$PATH':/usr/sbin'
PATH=$PATH':/usr/local/bin'
PATH=$PATH':/usr/local/sbin'
PATH=$PATH':/usr/bin/core_perl'
PATH=$PATH':/opt/pyshell/bin'
PATH=$PATH':'$HOME'/bin'
PATH=$PATH':/bin'
PATH=$PATH':/sbin'
export PATH

if [[ -e $PYSHELL_ROOT ]]; then
    export PYSHELL_DEBUG=0
    export PYSHELL_ROOT=/opt/pyshell
    export PYTHONPATH=$PYTHONPATH:'/opt/pyshell/lib'
    export SYNC_HOME=~/Dropbox/
fi


# ---[ Alias Section ]-------------------------------------------------
alias a='ack -a'
alias h='history'
alias ls='ls --color'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -Al'
alias mv='nocorrect mv'                # no spelling correction on mv
alias iptables='nocorrect iptables'    # no spelling correction on iptables
alias mkdir='nocorrect mkdir -p'       # no spelling correction on mkdir
alias df='df -kTh'
alias diff='colordiff'
alias pa='ps aux'
alias rm='rm -rf'
alias q='exit'
alias mmv='noglob zmv -W'

alias -s pdf=evince
alias -s chm=xchm
alias -s pl=perl
alias -s py=python
alias -s rb=ruby
alias -s {doc,docx,xls,xlsx,ppt,pptx,odt}=libreoffice
alias -s {jpg,jpeg,png,gif}=feh
alias -s {avi,mp4,mp3,mkv,VOB,flv,wmv}=vlc
alias -s {bz2,gz}=extract
alias -s rar='unrar x'
alias -s zip=unzip

alias -g B='&|'
alias -g C='| wc -l'
alias -g CA='2>&1 | cat -A'
alias -g H='| head'
alias -g HL='--help'
alias -g G='| grep'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g M='| most'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g S='| sort -n'
alias -g T='| tail'
alias -g X='| xargs'
alias -g X0='| xargs -0'

#---[ autojump ]-------------
if [[ -f /etc/profile.d/autojump.zsh ]]; then
    source /etc/profile.d/autojump.zsh
fi
#---[ Command not found ]-------------
if [[ -f /etc/profile.d/cnf.sh ]]; then
    source /etc/profile.d/cnf.sh
fi


# ---[ Key bindings ]--------------------------------------------------
bindkey -e
bindkey -s '^o' '^qranger\n'
bindkey -s '^p' '^qncmpc\n'
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[[C'  forward-char
bindkey '^[[D'  backward-char
bindkey '^k'    kill-line
bindkey '^[[3~' delete-char            # Del
bindkey '^[[2~' overwrite-mode         # Insert
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line


# ---[ Completition system ]-------------------------------------------
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _expand _complete _approximate #_match _ignored
zstyle ':completion:*' format '%B%d%b' # %B:Bold

zstyle ':completion:*' group-name ''
zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words|aliases)' group-name commands
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-separator '#'
zstyle ':completion:*' menu select=3 yes
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:expand:*' tag-order 'expansions original'
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command "ps -au$USER"
zstyle ':completion:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' command "ps --forest -u $USER -o cmd"


precmd () { vcs_info }

zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%u%c|%s:%b'
zstyle ':vcs_info:*' actionformats '%c%u|%s@%a:%b'
zstyle ':vcs_info:*' branchformat '%b@%r'
zstyle ':vcs_info:*' unstagedstr "%{$fg_no_bold[red]%}"
zstyle ':vcs_info:*' stagedstr "%{$fg_no_bold[yellow]%}"
zstyle ':vcs_info:*' enable svn git
zstyle ':vcs_info:git*:*' formats '%c%u|%s@%a:%b@%.5i'
zstyle ':vcs_info:git*:*' actionformats '%c%u|%s@%a:%b@%.5i'

# Prompt
setprompt
