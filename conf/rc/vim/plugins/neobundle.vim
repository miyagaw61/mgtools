" neobundle settings {{{
if has('vim_starting')
"set nocompatible
"set nocompatible
" neobundle をインストールしていない場合は自動インストール
if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
echo "install neobundle..."
" vim からコマンド呼び出しているだけ neobundle.vim のクローン
:call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
endif
" runtimepath の追加は必須
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'KeitaNakamura/neodark.vim'
"NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/sudo.vim'
"NeoBundle 'mattn/vim-fz'
"NeoBundle 'Shougo/vimproc', {
" 'build' : {
" 'windows' : 'make -f make_mingw32.mak',
" 'cygwin' : 'make -f make_cygwin.mak',
" 'mac' : 'make -f make_mac.mak',
" 'unix' : 'make -f make_unix.mak',
" },
" }
NeoBundle 'Shougo/neocomplete.vim'
" neocomplete {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    "    let g:neocomplete#enable_at_startup = 1
    "    let g:neocomplete#auto_completion_start_length = 3
    "    let g:neocomplete#enable_ignore_case = 1
    "    let g:neocomplete#enable_smart_case = 1
    "    let g:neocomplete#enable_camel_case = 1
    "    let g:neocomplete#use_vimproc = 1
    "    let g:neocomplete#sources#buffer#cache_limit_size = 1000000
    "    let g:neocomplete#sources#tags#cache_limit_size = 30000000
    "    let g:neocomplete#enable_fuzzy_completion = 1
    "    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" }}}
NeoBundleLazy 'Shougo/vimshell'
"NeoBundleLazy 'Shougo/vimshell', {
" 'depends' : 'Shougo/vimproc',
" 'autoload' : {
" 'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
" 'VimShellExecute', 'VimShellInteractive',
" 'VimShellTerminal', 'VimShellPop'],
" 'mappings' : ['<Plug>(vimshell_switch)']
" }}

" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}
NeoBundle 'LeafCage/yankround.vim'
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'glidenote/memolist.vim'
" memolist {{{
let g:memolist_path = expand('~/memolist')
let g:memolist_gfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_option = "-vertical -start-insert"
nnoremap mn :MemoNew<CR>
nnoremap ml :MemoList<CR>
nnoremap mg :MemoGrep<CR>
" }}}

"NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'easymotion/vim-easymotion'
" vim-easymotion {{{
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
" }}}
NeoBundleLazy 'junegunn/vim-easy-align', {
\ 'autoload': {
\ 'commands' : ['EasyAlign'],
\ 'mappings' : ['<Plug>(EasyAlign)'],
\ }}
" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}
NeoBundleLazy 'Shougo/neosnippet', {
\ 'depends' : 'Shougo/neosnippet-snippets',
\ 'autoload' : {
\ 'insert' : 1,
\ 'filetypes' : 'snippet',
\ }}
NeoBundle 'Shougo/neosnippet-snippets'
let g:neosnippet#data_directory = expand('~/.vim/etc/.cache/neosnippet')
let g:neosnippet#snippets_directory = [expand('~/.vim/.bundle/neosnippet-snippets/neosnippets'),expand('~/dotfiles/snippets')]
" neosnippet {{{
imap <C-t> <Plug>(neosnippet_expand_or_jump)
smap <C-t> <Plug>(neosnippet_expand_or_jump)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'Shougo/vinarise.git' 
" Vinarise{{
command! V :Vinarise
command! D :VinarisePluginDump
command! B :VinarisePluginBitmapView
" }}

NeoBundle 'terryma/vim-multiple-cursors'
" vim-multiple-cursors {{{
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
" }}}


" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" NEOBUNDLE END

