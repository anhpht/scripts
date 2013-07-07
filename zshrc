autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz zmv

# ---[ System settings ]------------------------------------------------
limit -s coredumpsize 0
umask 0027

setopt   ALWAYS_TO_END BASH_AUTO_LIST NO_BEEP CLOBBER
setopt   AUTO_CD CD_ABLE_VARS MULTIOS CORRECT_ALL
setopt   CHECK_JOBS NO_HUP

setopt   INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt   EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt   HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
DIRSTACKSIZE=20

# Stay compatible to sh and IFS
setopt   SH_WORD_SPLIT
setopt   notify globdots pushdtohome
setopt   recexact longlistjobs
setopt   autoresume pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt BG_NICE HUP autoparamslash

# Prompt
. ~/.zshprompt
setprompt

# Don't expand files matching:
fignore=(.o .c~)

# ---[ Environment ]---------------------------------------------------
#export CLICOLOR=1
#export LSCOLORS=dxfxcxdxbxegedabagacad
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.flv=01;35:*.mp4=01;35:*.mkv=01;35:*.xcf=01;35:*.VOB=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
export SHELL=zsh
export EDITOR=vim
export MANPAGER="/usr/bin/most -s"
export LANG=en_US.UTF-8
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export PS_PERSONALITY='linux'
export MANSECT=3:2:9:8:1:5:4:7:6:n
export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
export CSCOPE_DB=/home/fta/cscope/oam/cscope.out

PATH="/usr/bin"
PATH=$PATH":/usr/sbin"
PATH=$PATH":/usr/local/bin"
PATH=$PATH":/usr/local/sbin"
PATH=$PATH":/usr/bin/core_perl"
PATH=$PATH":/opt/pyshell/bin"
PATH=$PATH":"$HOME"/bin"
PATH=$PATH":/bin"
PATH=$PATH":/sbin"
export PATH

if [[ -e $PYSHELL_ROOT ]]; then
    export PYSHELL_DEBUG=0
    export PYSHELL_ROOT=/opt/pyshell
    export PYTHONPATH=$PYTHONPATH:"/opt/pyshell/lib"
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

#---[ autojump ]-------------
if [[ -f /etc/profile.d/autojump.zsh ]]; then
    source /etc/profile.d/autojump.zsh
fi
#---[ Command not found ]-------------
if [[ -f /etc/profile.d/cnf.sh ]]; then
    source /etc/profile.d/cnf.sh
fi


# ---[ Key bindings ]--------------------------------------------------
#bindkey -e
set -o emacs
bindkey -s '^o' '^qranger\n'
bindkey -s '^p' '^qncmpc\n'
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey "^[[C" forward-char
bindkey "^[[D" backward-char
bindkey '^k' kill-line
#bindkey "^[[H" beginning-of-line       # Home
#bindkey "^[[F" end-of-line             # End
bindkey '^[[3~' delete-char            # Del
bindkey '^[[2~' overwrite-mode         # Insert
bindkey '^[[2~' overwrite-mode         # ndkey    "\e[7~"    beginning-of-line
bindkey "[[8~" end-of-line
bindkey "[[7~" beginning-of-line


# ---[ Completition system ]-------------------------------------------
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' command 'ps --forest -u $USER -o cmd'

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=3 yes
zstyle ':completion:*' prompt 'Alternatives %e:'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle :compinstall filename '/home/fta/.zshrc'

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*:*' get-revision true
# ---[ Modules ]-------------------------------------------------------
#zmodload zsh/complist
#zmodload -a zsh/stat stat
#zmodload -a zsh/zpty zpty
#zmodload -ap zsh/mapfile mapfile
