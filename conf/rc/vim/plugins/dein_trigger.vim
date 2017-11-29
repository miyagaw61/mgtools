set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.cache/dein')
    call dein#begin('$HOME/.cache/dein')
    call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#load_toml('$REPOS/mgtools/conf/rc/vim/plugins/dein.toml',{'lazy' : 0})
    call dein#load_toml('$REPOS/mgtools/conf/rc/vim/plugins/dein_lazy.toml',{'lazy' : 1})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif
