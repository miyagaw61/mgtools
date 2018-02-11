jmp() {
    if test $# -eq 0 ;then
        cat $REPOS/mgtools/conf/jmp.conf
    elif test $1 = "add" ;then
        echo "$2: $(pwd)" >> $REPOS/mgtools/conf/jmp.conf
    else
        cd $(rg "$1: (.*)" -r '$1' -N $REPOS/mgtools/conf/jmp.conf)
    fi
}

recgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttyrec /tmp/.gif_record
}

mkgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttygif /tmp/.gif_record
    if test $# -ge 1 ;then
        mv tty.gif $1
        echo "[+]mv tty.gif "$1
    fi
    rm -rf /tmp/.gif_record
}

repobase(){
    now=$(pwd)/
    if test "$(echo $now | rg "/mnt/c/Users/miyagaw61/home/")" ;then
        now=$(echo $now | rg "/mnt/c/Users/miyagaw61/home/" -r "/home/miyagaw61/")
    fi
    now=$(echo "$now" | sed -E "s@$REPOS@@g")
    now=$(echo "$now" | sed -E "s@^/@@g")
    repo=$(echo "$now" | sed -E "s@/.*@@g")
    cd $REPOS/$repo
}

nv(){
    if test $# -eq 0 ;then
        nvr -c "Denite buffer"
    fi
    nvr -c "e "$(realpath $1)
}

nd(){
    nvr -c "cd "$(realpath $1)
}

#repos(){
#    var=$(rg --files $REPOS | rsed '[^/]*$' '' | sort | uniq | fzf2nd)
#    if test "$var" ;then
#        cd $var
#    fi
#}
#
red(){ #この関数を作らないとゼロマッチの時に何も出力されない
    arg="$(cat -)"
    echo "$arg" | rg "$1" -r "$2" -C 9999999999999999999
}

#readline_injection() {
#  READLINE_LINE="$READLINE_LINE | hoge"
#  READLINE_POINT=${#READLINE_LINE}
#}
#bind -x '"\C-j":readline_injection'
h() {
    cd $HOME/$1
}
h_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F h_completion h

r() {
    cd $HOME/repos/$1
}
r_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/repos/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F r_completion r

e() {
    cd $HOME/events/$1
}
e_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/events/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F e_completion e

d() {
    cd $HOME/docs/$1
}
d_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/docs/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F d_completion d
