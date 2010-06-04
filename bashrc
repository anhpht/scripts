if [ -f /etc/bashrc ]; then
    . /etc/bashrc

fi
PS1='\[\033[1;33m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;37m\]:\[\033[1;31m\]\w \[\033[1;36m\]\$ \[\033[0m\]'
# User specific aliases and functions

export MANPAGER="/usr/bin/most -s"
export LANG=en_US.UTF-8
export XMODIFIERS="@im=unikey"
#export GTK_IM_MODULE=”xim”
#Đe go duoc tieng Viet trong Openoffice thi can dat option nhu ben duoi
export GTK_IM_MODULE="unikey"

alias rm='rm -rf'
alias ls='ls --color'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -Al'
alias lm='ls -la |more'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias df='df -kTh'
alias path='echo -e ${PATH//:\\n}'
alias fn='find . -name'
alias xg='xargs grep -in'
alias ins='sudo apt-get install'
alias a='ack -a'
alias y='youtube-dl'
source /etc/profile.d/autojump.bash
function extract()
{
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)      tar xvjf $1;;
                        *.tar.gz)       tar xvzf $1;;
                        *.bz2)          bunzip2 $1;;
                        *.rar)          unrar x $1;;
                        *.gz)           gunzip $1;;
                        *.tar)          tar xvf $1;;
                        *.tbz2)         tar xvjf $1;;
                        *.tgz)          tar xvzf $1;;
                        *.zip)          unzip $1;;
                        *.Z)            uncompress $1;;
                        *.7z)           7z x $1 ;;
                        *)              echo "'$1' cannot be extracted via >extract<" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

cmdfu(){ curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"; }

cmdnew()
{
	wget -qO - http://www.commandlinefu.com/feed/tenup | xmlstarlet sel -T -t -o '&lt;x&gt;' -n -t -m rss/channel/item -o '&lt;y&gt;' -n -v description -o '&lt;/y&gt;' -n -t -o '&lt;/x&gt;' | xmlstarlet sel -T -t -m x/y -v code -n
}
function man2pdf(){ man -t ${1:?Specify man as arg} | ps2pdf -dCompatibility=1.3 - - > ${1}.pdf; }
function capture(){ ffmpeg -f x11grab -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -r 25 -i :0.0 -sameq ~/output.mpg > /dev/null 3>/dev/null; }
