" 行番号を表示
"set number
set relativenumber

" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
" set clipboard=autoselect

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed
set clipboard+=unnamedplus

"文字コードをUFT-8に設定
set fenc=utf-8
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
" 行末の1文字先までカーソルを移動できるように
set virtualedit=block
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
"set laststatus=2
set laststatus=0
" コマンドラインの補完
set wildmode=list:longest

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
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
"バックスペースを、空白、行末、行頭でも使えるようにする
set backspace=indent,eol,start
"クリップボード共有
set clipboard&
set clipboard^=unnamedplus

" カーソルの回り込みができるようになる
set nocompatible
set whichwrap=b,s,h,l,[,],<,>,~

" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" アンダーラインを引く(gui)
"highlight CursorLine gui=underline guifg=NONE guibg=NONE
