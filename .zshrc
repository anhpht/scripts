autoload -Uz compinit && compinit
autoload -Uz colors && colors
#autoload -Uz vcs_info
autoload -Uz zmv
autoload -U  zargs
autoload -U  age

zmodload zsh/files
zmodload zsh/complist

limit -s coredumpsize 0
umask    0022
source   /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
setopt   menucomplete
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
export XDG_CACHE_HOME="/dev/shm/.cache"
export BC_ENV_ARGS=~/.bcrc
export SHELL=/bin/zsh
export EDITOR=vim
export LANG=en_US.UTF-8
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export DE=xfce
export BROWSER=chromium
export MANSECT=3:2:9:8:1:5:4:7:6:n
#export OUT_DIR_COMMON_BASE=/mnt/data/dev/rk3188/build
export JAVA_HOME=/usr/lib/jvm/default-runtime

PATH=/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/bin/core_perl
PATH=$PATH:/opt/pyshell/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin
PATH=$PATH:/opt/android-ndk
export PATH

# Less Colors for Man Pages
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_us=$'\e[01;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_mr=$'\e[01;35m'
export LESS_TERMCAP_me=$'\e[00m'
export LESS_TERMCAP_ue=$'\e[00m'
export LESS_TERMCAP_se=$'\e[00m'
#export MANPAGER="/usr/bin/most -s"
export MANPAGER=less

if [[ -e $PYSHELL_ROOT ]]; then
    export PYSHELL_DEBUG=0
    export PYSHELL_ROOT=/opt/pyshell
    export PYTHONPATH=$PYTHONPATH:'/opt/pyshell/lib'
fi


# ---[ Alias Section ]-------------------------------------------------
alias a='ack'
alias ls='ls --color'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -Al'
alias mv='nocorrect mv'                # no spelling correction on mv
alias iptables='nocorrect iptables'    # no spelling correction on iptables
alias mkdir='nocorrect mkdir -p'       # no spelling correction on mkdir
alias df='df -kTh'
alias diff='colordiff'
alias d='colordiff'
alias pa='ps aux'
alias rm='rm -rf'
alias q='exit'
alias mmv='noglob zmv -W'
alias f='find . -name '
#alias grep="grep GREP_COLOR='0;35' --color=auto"
alias g=git
alias gi=gi

alias -s pdf=chromium
alias -s html=chromium
alias -s epub=/usr/bin/FBReader
alias -s chm=xchm
alias -s {doc,docx,xls,xlsx,ppt,pptx}=libreoffice
alias -s {jpg,jpeg,png,gif,JPG}=feh
alias -s {avi,mp4,mp3,mkv,VOB,flv,wmv}=vlc
alias -s {bz2,gz}=extract
alias -s rar='unrar x'
alias -s zip=unzip
alias -s exe=mono

alias -g G='| grep'
alias -g H='| head'
alias -g C='| wc -l'
alias -g L='| less'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
#alias -g B='&|'
#alias -g CA='2>&1 | cat -A'
#alias -g HL='--help'
#alias -g LL='2>&1 | less'
#alias -g M='| most'
#alias -g NE='2> /dev/null'
#alias -g NUL='> /dev/null 2>&1'
#alias -g S='| sort -n'
#alias -g T='| tail'
#alias -g X='| xargs'
#alias -g X0='| xargs -0'

#---[ autojump ]-------------
if [[ -f /etc/profile.d/autojump.zsh ]]; then
    source /etc/profile.d/autojump.zsh
fi


# ---[ Key bindings ]--------------------------------------------------
bindkey -e
bindkey -s '^n' '^qncmpc\n'
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[[C'  forward-char
bindkey '^[[D'  backward-char
bindkey '^k'    kill-line
bindkey '^[[3~' delete-char            # Del
bindkey '^[[2~' overwrite-mode         # Insert
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[H'  beginning-of-line


# ---[ Completion system ]-------------------------------------------
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '%B%d%b' # %B:Bold
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#zstyle ':completion:*:expand:*' tag-order 'expansions original'
#zstyle ':completion:*' completer _expand _complete _approximate #_match _ignored
zstyle ':completion:*' completer _complete
zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words|aliases)' group-name commands
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' list-separator '#'
zstyle ':completion:*' menu select=2 yes
#zstyle ':completion:*:approximate:*' max-errors 2
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command "ps -au$USER"
zstyle ':completion:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh_cache

#zstyle ':completion:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*' command "ps --forest -u $USER -o cmd"


#precmd () { vcs_info }
#
#zstyle ':vcs_info:*' get-revision true
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' formats '%u%c|%s:%b'
#zstyle ':vcs_info:*' actionformats '%c%u|%s@%a:%b'
#zstyle ':vcs_info:*' branchformat '%b@%r'
#zstyle ':vcs_info:*' unstagedstr "%{$fg_no_bold[red]%}"
#zstyle ':vcs_info:*' stagedstr "%{$fg_no_bold[yellow]%}"
#zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:git*:*' formats '%c%u|%s@%a:%b@%.5i'
#zstyle ':vcs_info:git*:*' actionformats '%c%u|%s@%a:%b@%.5i'

# Prompt
setprompt ()
{
    if [[ "$terminfo[colors]" -ge 8 ]]; then
        colors
    fi

    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        (( count = $count + 1 ))
    done

    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}

    PROMPT='$PR_YELLOW$PR_SHIFT_IN$PR_ULCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(\
$PR_YELLOW%(!.%SROOT%s.%n)$PR_GREEN@%m: $PR_LIGHT_RED%<...<%~%<<$PR_CYAN)${vcs_info_msg_0_}\

$PR_YELLOW$PR_SHIFT_IN$PR_LLCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(%(?..$PR_CYAN%?:)$PR_YELLOW%T$PR_GREEN on $PR_RED%w\
$PR_CYAN) $PR_SHIFT_OUT$PR_NO_COLOUR'
}

setprompt
ulimit -c unlimited
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup zsh-autosuggestions
source /mnt/data/github/zsh-autosuggestions-master/autosuggestions.zsh

# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}

zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^t' autosuggest-toggle
source /usr/lib/z.sh

PATH="/home/fta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/fta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/fta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/fta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fta/perl5"; export PERL_MM_OPT;
