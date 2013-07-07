# ---[ System settings ]------------------------------------------------
limit -s coredumpsize 0
umask 0027

# General
setopt   ALWAYS_TO_END BASH_AUTO_LIST NO_BEEP CLOBBER
setopt   AUTO_CD CD_ABLE_VARS MULTIOS CORRECT_ALL
# Job Control
setopt   CHECK_JOBS NO_HUP
# History
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

export MANPAGER="/usr/bin/most -s"
export LANG=en_US.UTF-8
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export PS_PERSONALITY='linux'
# Manpath & Manualpage search order
export MANSECT=3:2:9:8:1:5:4:7:6:n

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

export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
export CSCOPE_DB=/home/fta/cscope/oam/cscope.out
source /etc/profile.d/autojump.zsh


# ---[ Key bindings ]--------------------------------------------------
bindkey -s '^o' '^qranger\n'
bindkey -s '^p' '^qncmpc\n'
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey "^[[C" forward-char
bindkey "^[[D" backward-char
bindkey '^k' kill-line
bindkey "^[[H" beginning-of-line       # Home
bindkey "^[[F" end-of-line             # End
bindkey '^[[3~' delete-char            # Del
bindkey '^[[2~' overwrite-mode         # Insert
bindkey '^[[2~' overwrite-mode         # Insert


# ---[ Completition system ]-------------------------------------------
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=3 yes
zstyle ':completion:*' prompt 'Alternatives %e:'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/fta/.zshrc'

# ---[ Modules ]-------------------------------------------------------
zmodload zsh/complist
autoload -Uz compinit && compinit
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile
