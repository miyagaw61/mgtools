export HOME=/home/miyagaw61
export MGTOOLS_ROOT=/home/miyagaw61/repos/mgtools

source $MGTOOLS_ROOT/conf/rc/default_bashrc

#bash color
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

usericon='?'
if test $USER = 'root';then
	usericon='#'
else
	usericon='$'
fi

if [ "$color_prompt" = yes ]; then
    USER_COLOR='\[\033[01;36m\]' # cyan
    back_green='\[\033[42m\]' # cyan
    HOST_COLOR='\[\033[01;31m\]' # red
    PWD_COLOR='\[\033[01;31m\]' # red
    black='\[\033[01;30m\]' # black
    RESET_COLOR='\[\033[00m\]'
    white='\[\033[00m\]'
    backGreen_white='\[\033[00;42m\]'
    backGreen_black='\[\033[30;42;1m\]'
    backGreen_red='\[\033[31;42;1m\]'
    backBlack_green='\[\033[32;40m\]'
    backCyan_red='\[\033[31;46;1m\]'
    backRed_green='\[\033[32;41;1m\]'
    backGreen_blue='\[\033[34;42m\]'
    green='\[\033[32;1m\]'
    green_0='\[\033[32m\]'
    blue='\[\033[34;1m\]'
    blue_0='\[\033[34;0m\]'
    red='\[\033[31;1m\]' # red
    cyan='\[\033[36;1m\]'
    cyan_0='\[\033[36m\]'
    magenta='\[\033[35m\]'
    #PS1="${debian_chroot:+$debian_chroot)}${cyan}\u${red}@${cyan}\w${white}\$ "

    #if test $USER = "root" ;then
    #    PS1="${debian_chroot:+$debian_chroot)}${red}(${cyan}\W${red})${white} "
    #else
    #    PS1="${debian_chroot:+$debian_chroot)}$USER@\w\$ "
    #fi
    #PS1="${debian_chroot:+$debian_chroot)}${red}(${cyan}\W${red})${white} "
    #PS1="${debian_chroot:+$debian_chroot)}.-\u@\w\n\`--> "

    function parse_branch(){
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        if test $(($(echo $branch | wc -m)-1)) -gt 1 ;then
            if test $USER = "root" ;then
                echo -ne "\033[01;30m:\033[36;1m${branch}\033[00m"
            else
                echo -ne "\033[01;30m:\033[32;1m${branch}\033[00m"
            fi
        fi
    }

    function parse_branch(){
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        if test $(($(echo $branch | wc -m)-1)) -gt 1 ;then
            if test $USER = "root" ;then
                echo -ne "\033[36;1m[${branch}]\033[00m"
            else
                echo -ne "\033[31;1m[${branch}]\033[00m"
            fi
        else
            if test $USER = "root" ;then
                echo -ne "\033[36;1m[None]\033[00m"
            else
                echo -ne "\033[31;1m[None]\033[00m"
            fi
        fi
    }


    function parse_pyenv(){
        pyenv=$(pyenv local 2> /dev/null)
        if test $(($(echo $pyenv | wc -m)-1)) -gt 3 ;then
            if test $USER = "root" ;then
                echo -ne "\033[1;31m─\033[1;36m[${pyenv}]"
            else
                echo -ne "\033[1;36m─\033[1;31m[${pyenv}]"
            fi
        else
            if test $USER = "root" ;then
                echo -ne "\033[1;31m─\033[1;36m[None]"
            else
                echo -ne "\033[1;36m─\033[1;31m[None]"
            fi
        fi
    }

    function parse_prompt(){
        branch_len="0"
        len=$(pwd | wc -m)
        if test "$(pwd | grep '/home/miyagaw61')" ;then
            len=$(($len-14-1))
        fi
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        branch_len=$(echo -n $branch | wc -m)
        if test $branch_len != "0" ;then
            len=$(($len+$branch_len))
            len=$(($len+1))
        fi
        if test ! "$(pwd | grep '/home/miyagaw61')" ;then
            len=$(($len+6))
        fi
        size=$(stty size) 
        size=$(echo $size | sed -E "s@(.*) (.*)@\2@g")
        num=$(($size-$len))
        num=$(($num-5))
        #pylen=$(pyenv local 2> /dev/null | wc -m)
        #pylen=$(($pylen-1))
        #if test ! $pylen -eq 0 ;then
        #    pylen=$(($pylen+6))
        #fi
        #num=$(($num-$pylen))
        for x in $(seq 1 $num) ;do
            echo -n '-'
        done
    }

    PS1="${cyan}.-${black}(${red}\w${black})${cyan}-${blue}-${black}-${cyan}\n'---> ${white}"
    PS1="${cyan}.-${black}(${green}\w${black})${cyan}-${blue}-${black}-${cyan}\n'---> ${white}"
    PS1="${red}.-${black}(${green}\w${black})${red}-${magenta}-${black}-${red}\n'---> ${white}"
    PS1="${red}.-${black}(${green}\w${black})${red}-${black}-${red}\n'---> ${white}"
    PS1="${cyan}.---${black}(${red}\w\$(parse_branch)${black})\$(parse_pyenv)${cyan}\$(parse_prompt)\n'--> ${white}"
    PS1="${cyan}.--${black}(${red}\w\$(parse_branch)${black})${cyan}\$(parse_prompt)\n'--> ${white}"
    PS1="${cyan}.-${red}[\w]\$(parse_branch)\$(parse_pyenv)${cyan}\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${red}[miyagaw61]${cyan}-${green}$ ${white}"
    PS1="${cyan}┌\$(parse_branch)\$(parse_pyenv)\n${cyan}└─${red}[\w]\n${red}◈ ${white}"
    if test $USER = "root" ;then
        PS1="${red}.--${black}(${green}\w\$(parse_branch)${black})${red}\$(parse_prompt)\n\$(cat $HOME/repos/mgtools/conf/back_quote)--> ${white}"
        PS1="${red}.-${green}[\w]${red}-\$(parse_branch)${red}\$(parse_prompt)\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${cyan}[miyagaw61]${red}-> ${white}"
        PS1="${red}.-${cyan}[\w]\$(parse_branch)\$(parse_pyenv)${red}\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${cyan}[miyagaw61]${red}-${green}$ ${white}"
        PS1="${red}┌─${cyan}[\w]\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[miyagaw61]${red}◈ ${white}"
        PS1="${red}┌\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[\w]${red}◈ ${white}"
        PS1="${red}┌─\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[\w]\n${cyan}◈ ${white}"
    fi

    #PS1="${debian_chroot:+$debian_chroot)}${cyan}\u${red}:\w${white}\n${usericon}"
    #PS1="${debian_chroot:+$debian_chroot)}${red}\w        \n${RESET_COLOR}${red}${usericon} ${white}"
    #PS1="${debian_chroot:+$debian_chroot)}${green}\w        \n${RESET_COLOR}${green}${usericon} ${white}"
    #PS1="${debian_chroot:+$debian_chroot)}${green}[${red}${usericon}${green}]${red}\W : ${white}"
fi

unset color_prompt force_color_prompt

#ここにsudは絶対に書くな

#alias python
alias p='python'

#alias ls
alias lf='ls -CF'
alias dls='ls'
alias o='ols'
alias l='ols'
alias ls1='olsone'
alias l1='olsone'
#alias ls='now; ls --color=auto'


#alias dvorak to jp
alias j='. j'
alias h='. h'
alias no='. no'

#alias jp to dvorak
alias e='source ~/.bashrc'

#alias rc
alias viba='vim ~/.bashrc; rsync -au ~/.bashrc $MGTOOLS_ROOT/rc/bashrc/bashrc'
alias soba='. ~/.bashrc 2> /dev/null'
alias vivi='vim ~/.vimrc; rsync -au ~/.vimrc $MGTOOLS_ROOT/conf/rc/vimrc/vimrc'

#alias vivi='vim $HOME/.config/nvim/init.vim; rsync -au $HOME/.config/nvim/init.vim $HOME/Documents/git/mgtools/conf/rc/'

#gdb alias
alias altest='source al'

#xkb
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY 2> /dev/null

#alias objdump
alias objdump='objdump -M intel'

#alias diff
alias diff='diff -a -r -u -p'

#alias less
alias less='less -iMSR'

#alias gcc
alias gcc='gcc -I $HOME/Documents/git/mgtools/include/'

#virtualenv

### Virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

#alias docker ctf
alias cdock='docker run -v /home/miyagaw/ctf/:/root/ctf/ -it --name ctf ubuntu14i386 bash'
alias c2h='docker cp ctf:/root/ctf/ /home/miyagaw/'

#alias numcd
#source $HOME/Documents/git/mgtools/numcd.alias

#export golang
export GOPATH=$HOME/go/thirdparty:$HOME/go/myproject
export PATH=$HOME/go/thirdparty/bin:$HOME/go/myproject/bin:$PATH
export GO15VENDOREXPERIMENT=1

#bind
bind '"\C-g":end-of-line'

#alias cp
alias cp='cp -a'

#alias re
alias re='reboot'

#alias sd
alias sd='shutdown -h now'

#alias sud
alias sud='sudo bash'

#alias a
alias a='cd ../'

#alias xargs
alias to='xargs'

#alias rs
alias rs='rsync -av'
alias rsu='rsync -auv'

#alias mnt
alias mnt='cd /mnt/windows/bk/'

#alias sl
alias sl='ls'

#mntDirectoryEnv
MNT='/mnt/windows/bk'

#alias pgdb
alias pg='pgdb'

#aliaas ipcalc
alias ipcalc='python $HOME/Documents/git/mgtools/ipcalc.py'

#alias docker2
alias dk='docker2'

#alias save
alias save='cat $HOME/Documents/save'


#alias for git2nd
#alias gi='git2nd'
#alias gis='git2nd status'
#alias gim='git2nd m'
#alias gif='git2nd diff'
#alias gia='git2nd add'
#alias gic='git2nd commit'
#alias gim='git2nd merge'
#alias gip='git2nd push'
#alias gib='git2nd branch'
#alias gicm='git2nd cm'
#alias gicp='git2nd cp'
#alias gicmp='git2nd cmp'
#alias gimp='git2nd mp'
#alias giac='git2nd ac'
#alias giacm='git2nd acm'
#alias giacp='git2nd acp'
#alias giacmp='git2nd acmp'

alias chro='google-chrome'

#export ponpontools
export PATH=$PATH:$HOME/ponpontools/commands/

alias rem="mvtrash"

alias vagrant="sudo vagrant"

#pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export PATH="$HOME/neovim/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export LSFTMP=""

alias c="cat \$(fzf__select__)"
alias d="cd \$(__fzf_myselect_cd__)"
alias v="vim \$(__fzf_select__)"
alias fd="echo 'cd '\$(cat $HOME/Documents/git/mgtools/.tmp/lsf.out) > $HOME/Documents/git/mgtools/.tmp/lsf.vd; source $HOME/Documents/git/mgtools/.tmp/lsf.vd"

function jmp() {
    if test $# -eq 0 ;then
        cat $HOME/Documents/git/mgtools/conf/jmp.conf
    elif test $1 = "add" ;then
        echo $2 >> $HOME/Documents/git/mgtools/conf/jmp.conf
    else
        cat $HOME/Documents/git/mgtools/conf/jmp.conf | grep -oP "^$1:.*$" | perl -pe "s@$1:(.*)@\1@g" > $HOME/Documents/git/mgtools/.tmp/jmp.tmp
        echo "cd "$(cat $HOME/Documents/git/mgtools/.tmp/jmp.tmp) > $HOME/Documents/git/mgtools/.tmp/jmp.tmp.tmp
        mv $HOME/Documents/git/mgtools/.tmp/jmp.tmp.tmp $HOME/Documents/git/mgtools/.tmp/jmp.tmp
        source $HOME/Documents/git/mgtools/.tmp/jmp.tmp
    fi
}
alias j="jmp"

alias remotesock="socat -d -d unix-connect:/tmp/gdbsock pty,raw,echo=0 &"

export USR="$(basename $HOME)"
alias rm="rm -rf"


alias nls="ls | nms"

#bind -x \C-s "search ,\t"
alias xcp="xsel --clipboard --input"

export EDITOR="$HOME/bin/viim/bin/vim"
export PATH=$PATH:/usr/local/bin

export PATH=$PATH:/home/miyagaw61/git/git2nd/git2nd
export PATH=$PATH:/home/miyagaw61/git/git2nd
export GIT_NAME='miyagaw61'
export GIT_EMAIL='miyagaw61@gmail.com'

function recgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttyrec /tmp/.gif_record
}

function mkgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttygif /tmp/.gif_record
    if test $# -ge 1 ;then
        mv tty.gif $1
        echo "[+]mv tty.gif "$1
    fi
    rm -rf /tmp/.gif_record
}
alias x="python exploit.py"
alias r="python exploit.py"
alias d="python exploit.py d"
alias vx="vim ./exploit.py"
alias apt="sudo apt -y"
alias rm="sudo rm"
alias vim="$HOME/viim/bin/vim"
alias vim="$HOME/bin/viim/bin/vim"

function gd(){
    gdb -x ./gdbrc $1
}

alias pyv="python $HOME/Documents/git/mgtools/pyv.py"
alias update="apt -y update; apt -y upgrade; slk"
export PATH=$PATH:$HOME/bin
export PATH=$HOME/.cargo/bin:$PATH
alias rip="rip --graveyard $HOME/.trash"

function mov(){
    if test $# -eq 2 ;then
        if test -e $2 ;then
            if test ! -d $2 ;then
                rip $2
            fi
        fi
        mv $1 $2
    else
        echo Usage: mov [src] [dst]
    fi
}

function copy(){
    if test $# -eq 2 ;then
        if test -e $2 ;then
            rip $2
        fi
        cp -a $1 $2
    else
        echo Usage: copy [src] [dst]
    fi
}

alias pbcopy="xsel --clipboard --input"

export PATH=$PATH:$MGTOOLS_ROOT
export PATH=$PATH:$HOME/bin/win32yank-x64
