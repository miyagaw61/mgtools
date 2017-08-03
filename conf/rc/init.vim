
" dein.vim設定
set runtimepath^=~/.deinvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.deinvim/dein')
  call dein#begin('~/.deinvim/dein')
  call dein#load_toml('~/.deinvim/dein.toml',{'lazy' : 0})
  call dein#load_toml('~/.deinvim/dein_lazy.toml',{'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=block
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" Tab文字を半角スペースにする
set expandtab
"" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
"" 行頭でのTab文字の表示幅
set shiftwidth=4


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" カーソルの回り込みができるようになる
set whichwrap=b,s,[,],<,>
"バックスペースを、空白、行末、行頭でも使えるようにする
set backspace=indent,eol,start
"クリップボード共有
set clipboard+=unnamedplus

"最後のカーソル位置を記憶
autocmd BufWinLeave ?* silent mkview
autocmd BufWinEnter ?* silent loadview

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :%!xxd -r<CR>

"highlight CursorColumn ctermbg=Black

set whichwrap=b,s,[,],<,>

" ---- jp ----
noremap j gj
noremap k gk
noremap gl <C-w>l
noremap gh <C-w>h
noremap gj <C-w>j
noremap gk <C-w>k
inoremap <C-h> <left>
inoremap <C-l> <right>
"inoremap <C-k> <up>
"inoremap <C-j> <down>
inoremap <C-j> <esc>
inoremap <C-x> <esc>
tnoremap <C-j> <C-\><C-n>
tnoremap <ESC> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
inoremap <C-a> <home>
inoremap <C-g> <end>
nnoremap <C-a> <home>
nnoremap <C-g> <end>
" ---- jp ----

"color scheme
syntax on
colorscheme molokai
set t_Co=256
"set termguicolors
set background=dark

" deoplete
let g:deoplete#enable_at_startup = 1
let s:srcpath = expand('$HOME/.deinvim/dein/repos/github.com')
call dein#local(s:srcpath, {'on_ft': ['python', 'cython', 'pyrex'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-jedi'])
hi CursorLine guifg=#E19972
"call dein#local(s:srcpath, {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'frozen': 1, 'merged': 0}, ['zchee/deoplete-clang'])
"function! DeopleteConfig()
    "call deoplete#custom#set('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
    "call deoplete#custom#set('_', 'min_pattern_length', 1)
    "call deoplete#custom#set('buffer', 'rank', 100)
    "call deoplete#custom#set('go', 'matchers', ['matcher_fuzzy'])
    "call deoplete#custom#set('go', 'sorters', [])
    "call deoplete#custom#set('jedi', 'disabled_syntaxes', ['Comment'])
    "call deoplete#custom#set('jedi', 'matchers', ['matcher_fuzzy'])
    "call deoplete#custom#set('neosnippet', 'disabled_syntaxes', ['goComment'])"
    "call deoplete#custom#set('ternjs', 'rank', 0)
    "call deoplete#custom#set('vim', 'disabled_syntaxes', ['Comment'])
"endfunction

" vim-easymotion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap S <Plug>(easymotion-sn)
xmap S <Plug>(easymotion-sn)
omap S <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
    " let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_keys = 'Q1Z2A3S4D5F6G7H8J9K/;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1

"terminal close
function! s:termexit() abort
    execute 'buffer #'
endfunction
autocmd! TermClose * call s:termexit()

