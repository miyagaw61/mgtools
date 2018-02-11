#set default useful options
alias diff='diff -a -r -u -p'
alias objdump='objdump -M intel'
alias less='less -iMSR'
alias cp='cp -a'

#be short
alias a='cd ../'
alias j="jmp"
alias p='python'
alias re='reboot'
alias sd='shutdown -h now'
alias rs='rsync -av'
alias rsu='rsync -auv'
alias pbcopy="xsel --clipboard --input"
alias xl="pbcopy"
alias pt="xsel -o"
alias x="python exploit.py"
alias vx="vim ./exploit.py"
alias update="apt -y update; apt -y upgrade; slk"
alias dk='docker2'
alias sud='sudo bash'
alias pg='pgdb'
alias f='fzf2nd'
alias op='xdg-open'
alias rusgit='/mnt/c/Users/miyagaw61/home/repos/rusgit/target/debug/rusgit'

#alias ls
alias ls='exa --group-directories-first'
alias ll='exa -hal --git --time-style=iso --group-directories-first'

#alias rc
alias viba='vim ~/.bashrc; rsync -au ~/.bashrc $MGTOOLS_ROOT/conf/rc/bash/bashrc'
alias soba='. ~/.bashrc 2> /dev/null'
alias caba='cat ~/.bashrc'
alias vivi='vim ~/.config/nvim/init.vim; rsync -au ~/.config/nvim/init.vim $MGTOOLS_ROOT/conf/rc/vim/vimrc'
alias cavi='cat ~/.config/nvim/init.vim'

#my config
alias gcc='gcc -I $HOME/Documents/git/mgtools/include/'
alias vim="$HOME/bin/viim/bin/vim"
alias ns="rm -rf /tmp/nvimsocket; NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias sl='ls'

#cd
alias docs="cd $HOME/docs"
alias events="cd $HOME/events"

#alias make malware list
alias malist="allcp \$(rg --files -g*.exe -g*.bat -g*.scr -g*.rtf -g*.cpl -g*.jar -g*.lnk) -d"

#alias rusgit
alias rusgit="$HOME/repos/rusgit/target/debug/rusgit"
eval "$(rusgit complete --add ra --ac rac --diff rd --branch rb --undo ru --tag rt --push rpush --pull rpull --merge rmerge --rebase rrebase --log rl --commit rc --clone rclone)"
alias rs="rusgit status --ls 'exa --group-directories-first'"
