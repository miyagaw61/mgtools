
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

"terminal close
function! s:termexit() abort
    execute 'buffer #'
endfunction
autocmd! TermClose * call s:termexit()

" :vim <str> %
nnoremap [q :cprevious<CR> " 前へ
nnoremap ]q :cnext<CR> " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR> " 最後へ

" vim -b
augroup BinaryXXD
autocmd!
autocmd BufReadPre *.bin let &binary =1
" autocmd BufReadPost * if &binary | silent %!xxd -g 1
autocmd BufReadPost * if &binary | Vinarise | endif
" autocmd BufReadPost * set ft=xxd | endif
" autocmd BufWritePre * if excute \"%!xxd -r\" | endif
" autocmd BufWritePost * if &binary | silent %!xxd -g 1
" autocmd BufWritePost * set nomod | endif
augroup END

" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
" http://nanasi.jp/articles/howto/editing/clipboard.html
" set clipboard=autoselect

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed
set clipboard+=unnamedplus

"add by me

" setting
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

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように



filetype plugin indent on

" カーソルの回り込みができるようになる
set nocompatible
set whichwrap=b,s,h,l,[,],<,>,~

"color scheme
syntax on
colorscheme molokai
set t_Co=256
set termguicolors
set background=dark

" scb_vsplit
function! g:Scb_vsplit()
    set noscb
    rightbelow vsplit
    set noscb
    normal gGCf
    normal gGCe
    normal gGCe
    set scb
    normal gh
    set scb
endfunction


"augroup scb_vsplit
"    au!
"    autocmd VimEnter * call s:scb_vsplit()
"augroup END

nnoremap <leader>v :call Scb_vsplit()<CR>

"nnoremap <C-h> :Gtags -f %<CR>
nnoremap <C-j> :GtagsCursor<CR>
nnoremap <C-h> <C-w><C-w>ZQ
"nnoremap <C-n> :cn<CR>
"nnoremap <C-p> :cp<CR>
"nnoremap <C-d> <C-w><C-w>ZQ

""##### auto fcitx  ###########
"let g:input_toggle = 1
"function! Fcitx2en()
"   let s:input_status = system("fcitx-remote")
"   if s:input_status == 2
"      let g:input_toggle = 1
"      let l:a = system("fcitx-remote -c")
"   endif
"endfunction
"
"function! Fcitx2zh()
"   let s:input_status = system("fcitx-remote")
"   if s:input_status != 2 && g:input_toggle == 1
"      let l:a = system("fcitx-remote -o")
"      let g:input_toggle = 0
"   endif
"endfunction
"
"set ttimeoutlen=150
"
"autocmd InsertLeave * call Fcitx2en()
""autocmd InsertEnter * call Fcitx2zh()
""##### auto fcitx end ######


""Windows
"nnoremap <silent>yy "*yy
"nnoremap <silent>p "*p
"colorscheme kalisi
""半角文字の設定
"set guifont=MS_Gothic:h10
""全角文字の設定
"set guifontwide=MS_Gothic:h10
""挿入モード時のデフォルトモード
"nnoremap <leader>e :set iminsert=1<CR>:set imsearch=-1<CR>
""横幅MAX

