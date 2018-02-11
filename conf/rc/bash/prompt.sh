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
    white='\033[00m'
    backGreen_white='\[\033[00;42m\]'
    backGreen_black='\[\033[30;42;1m\]'
    backGreen_red='\[\033[31;42;1m\]'
    backBlack_green='\[\033[32;40m\]'
    backCyan_red='\[\033[31;46;1m\]'
    backRed_green='\[\033[32;41;1m\]'
    backGreen_blue='\[\033[34;42m\]'
    green='\[\033[32;1m\]'
    green='\033[32;1m'
    green_0='\[\033[32m\]'
    blue='\[\033[34;1m\]'
    blue='\033[34;1m'
    blue_0='\[\033[34;0m\]'
    blue_0='\033[34;0m'
    red='\[\033[1;31m\]' # red
    red='\033[1;31m' # red
    cyan='\[\033[1;36m\]'
    cyan='\033[36;1m'
    yellow='\033[33;1m'
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

    function parse_branch(){
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        if test $(($(echo $branch | wc -m)-1)) -gt 1 ;then
            #if test $USER = "root" ;then
            #    #echo -ne "\033[31;1m[ \033[36;1m${branch} \033[31;1m]\033[00m"
                echo -ne "\033[31;1m[ ${yellow}${branch} \033[31;1m]\033[00m"
            #else
            #    echo -ne "\033[31;1m-[\033[36;1m[ ${branch} ]\033[00m"
            #fi
        #else
        #    if test $USER = "root" ;then
        #        echo -ne "\033[36;1m[None]\033[00m"
        #    else
        #        echo -ne "\033[36;1m[None]\033[00m"
        #    fi
        fi
    }

    function parse_path(){
        now=$(pwd)/
        base=$(basename $now)
        if test $(echo "$now" | grep "$REPOS/") ;then
            now=$(echo "$now" | sed -E "s@$REPOS@@g")
            if test $now = "/" ;then
                #now=${blue}repos${cyan}
                now=${cyan}repos${cyan}
            else
                now=$(echo "$now" | sed -E "s@^/@@g")
                repo=$(echo "$now" | sed -E "s@/.*@@g")
                unrepo=$(echo "$now" | sed -E "s@^$repo@@g")
                unrepo=$(echo "$unrepo" | sed -E "s/\/$//g")
                unrepo=$(echo $unrepo | sed -E "s@$base@@g")
                if test "$(echo "$unrepo" | grep .)" ;then
                    #now=${blue}$repo${white}$unrepo${cyan}$base
                    now=${cyan}$repo${white}$unrepo${cyan}$base
                else
                    #now=${blue}$base
                    now=${cyan}$base
                fi
            fi
        elif test $(echo "$now" | grep "$HOME/events/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/events@@g")
            if test $now = "/" ;then
                #now=${blue}events${cyan}
                now=${cyan}events${cyan}
            else
                now=$(echo "$now" | sed -E "s@^/@@g")
                repo=$(echo "$now" | sed -E "s@/.*@@g")
                unrepo=$(echo "$now" | sed -E "s@^$repo@@g")
                unrepo=$(echo "$unrepo" | sed -E "s/\/$//g")
                unrepo=$(echo $unrepo | sed -E "s@$base@@g")
                if test "$(echo "$unrepo" | grep .)" ;then
                    #now=${blue}$repo${white}$unrepo${cyan}$base
                    now=${cyan}$repo${white}$unrepo${cyan}$base
                else
                    #now=${blue}$base
                    now=${cyan}$base
                fi
            fi
        elif test $(echo "$now" | grep "$HOME/docs/text/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/text@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME/docs/music/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/music@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME/docs/pictures/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/pictures@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME/docs/movies/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/movies@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME/docs/documents/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/documents@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME/docs/school/") ;then
            now=$(echo "$now" | sed -E "s@$HOME/docs/school@@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
            now=$(echo "$now" | sed -E "s@$base@@g")
            if test "$(echo "$now" | grep .)" ;then
                now=${blue}$base${white}$now${cyan}$base
            else
                now=${blue}$base
            fi
        elif test $(echo "$now" | grep "$HOME") ;then
            now=$(echo "$now" | sed -E "s@$HOME@~@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
        fi
        echo -ne "$now"
    }

    upper_left="┌"
    bottom_left="└"
    bar="─"
    bold_bar="━"
    left_partical="┤"
    #PS1="${cyan}.-${black}(${red}\w${black})${cyan}-${blue}-${black}-${cyan}\n'---> ${white}"
    #PS1="${cyan}.-${black}(${green}\w${black})${cyan}-${blue}-${black}-${cyan}\n'---> ${white}"
    #PS1="${red}.-${black}(${green}\w${black})${red}-${magenta}-${black}-${red}\n'---> ${white}"
    #PS1="${red}.-${black}(${green}\w${black})${red}-${black}-${red}\n'---> ${white}"
    #PS1="${cyan}.---${black}(${red}\w\$(parse_branch)${black})\$(parse_pyenv)${cyan}\$(parse_prompt)\n'--> ${white}"
    #PS1="${cyan}.--${black}(${red}\w\$(parse_branch)${black})${cyan}\$(parse_prompt)\n'--> ${white}"
    #PS1="${cyan}.-${red}[\w]\$(parse_branch)\$(parse_pyenv)${cyan}\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${red}[miyagaw61]${cyan}-${green}$ ${white}"
    #PS1="${cyan}┌\$(parse_branch)\$(parse_pyenv)\n${cyan}└─${red}[\w]\n${red}◈ ${white}"
    #PS1="${red}${upper_left}${bar}${cyan}[\w]\$(parse_branch)\n${red}${bottom_left}${bar}${cyan}\$(cat $MGTOOLS_ROOT/conf/rc/bash/dollar)\$(cat $MGTOOLS_ROOT/conf/rc/bash/left_parenthesis)${white}"
    #PS1="${red}${upper_left}${bar}${cyan}[\w]\$(parse_branch)\n${red}${bottom_left}${bar}${cyan}\$(cat $MGTOOLS_ROOT/conf/rc/bash/dollar)\$(cat $MGTOOLS_ROOT/conf/rc/bash/left_parenthesis)${white}"
    #PS1="${red}${upper_left}${bar}${cyan}[\w]\$(parse_branch)\n${red}${bottom_left}${bar} ${cyan}>> ${white}"
    #PS1="(\w)"
    PS1="\n${red}[ ${cyan}\$(parse_path)${red} ]\n\[${red}\]>> \[${white}\]"
    PS1="\n${red}[ ${cyan}\$(parse_path)${red} ]\$(parse_branch)\n\[${red}\]>> \[${white}\]"
    #if test $USER = "root" ;then
        #PS1="${red}.--${black}(${green}\w\$(parse_branch)${black})${red}\$(parse_prompt)\n\$(cat $HOME/repos/mgtools/conf/back_quote)--> ${white}"
        #PS1="${red}.-${green}[\w]${red}-\$(parse_branch)${red}\$(parse_prompt)\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${cyan}[miyagaw61]${red}-> ${white}"
        #PS1="${red}.-${cyan}[\w]\$(parse_branch)\$(parse_pyenv)${red}\n\$(cat $HOME/repos/mgtools/conf/back_quote)--${cyan}[miyagaw61]${red}-${green}$ ${white}"
        #PS1="${red}┌─${cyan}[\w]\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[miyagaw61]${red}◈ ${white}"
        #PS1="${red}┌\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[\w]${red}◈ ${white}"
        #PS1="${red}┌─\$(parse_branch)\$(parse_pyenv)\n${red}└─${cyan}[\w]\n${cyan}◈ ${white}"
        #PS1="${red}${upper_left}${bar}${cyan}[\w]\$(parse_branch)\n${red}${bottom_left}${bar} ${cyan}>> ${white}"
        #PS1="${cyan}(\w)\$(parse_branch)\n${red}\$(cat $MGTOOLS_ROOT/conf/rc/bash/dollar) ${white}"
        #PS1="${cyan}[\w]\$(parse_branch)\n${red}>> ${white}"
        #PS1="${cyan}(\w)\$(parse_branch)\n${red}\$(cat $MGTOOLS_ROOT/conf/rc/bash/dollar) ${white}"
        #PS1="${cyan}(\w)\$(parse_branch)\n${red}\$(cat $MGTOOLS_ROOT/conf/rc/bash/dollar)\$(cat $MGTOOLS_ROOT/conf/rc/bash/left_parenthesis) ${white}"
        #PS1="\n${red}[ ${cyan}\w${red} ]\$(parse_branch)\n${red}>> ${white}"
        #PS1="\n${red}[ ${cyan}\$(parse_path)${red} ]\$(parse_branch)\n\[${red}\]>> \[${white}\]"
    #fi

    #PS1="${debian_chroot:+$debian_chroot)}${cyan}\u${red}:\w${white}\n${usericon}"
    #PS1="${debian_chroot:+$debian_chroot)}${red}\w        \n${RESET_COLOR}${red}${usericon} ${white}"
    #PS1="${debian_chroot:+$debian_chroot)}${green}\w        \n${RESET_COLOR}${green}${usericon} ${white}"
    #PS1="${debian_chroot:+$debian_chroot)}${green}[${red}${usericon}${green}]${red}\W : ${white}"
fi

unset color_prompt force_color_prompt
