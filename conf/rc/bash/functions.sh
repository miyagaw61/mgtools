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

function repobase(){
    now=$(pwd)/
    now=$(echo "$now" | sed -E "s@$REPOS@@g")
    now=$(echo "$now" | sed -E "s@^/@@g")
    repo=$(echo "$now" | sed -E "s@/.*@@g")
    cd $REPOS/$repo
}
