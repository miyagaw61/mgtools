" :vim <str> %
nnoremap [q :cprevious<CR> " 前へ
nnoremap ]q :cnext<CR> " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR> " 最後へ

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"SET LEADER
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :%!xxd -r<CR>

noremap j gj
noremap k gk
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gh <C-w>h
nnoremap gl <C-w>l
nnoremap [Window] <Nop>
nmap s [Window]
nmap <Space> [Space]
inoremap <C-j> <esc>
inoremap <C-a> <home>
inoremap <C-e> <end>
"inoremap <C-h> <left>
"inoremap <C-l> <right>
nnoremap <leader>vim :set syntax=vim<CR>
nnoremap <leader>python :set syntax=python<CR>
nnoremap <leader>clang :set syntax=python<CR>
nnoremap <leader>md :set syntax=markdown<CR>
nnoremap <leader>jelly :colorscheme jellybeans<CR>
nnoremap <leader>molokai :colorscheme molokai<CR>
nnoremap <leader>kalisi :colorscheme kalisi<CR>:set background=light<CR>
nnoremap <leader>neodark :colorscheme neodark<CR>
nnoremap <leader>repos :cd $REPOS<CR>
nnoremap gGCf <C-f>
nnoremap gGCb <C-b>
nnoremap gGCe <C-e>
nnoremap gGCy <C-y>
nnoremap gGCd <C-d>
nnoremap gGCu <C-u>
tnoremap <C-j> <C-\><C-n>
nnoremap <Tab> <Nop>
nnoremap [Window]n :tabn<CR>
nnoremap e :cd %:p:h<CR>:e<Space>

"terminal mapping
nnoremap [Space]t  :Deol<CR>
nnoremap [Space]s  :b bash<CR>:call deol#send("cd " . expand("#:p:h"))<CR>i
nnoremap [Space]ga :b bash<CR>:call deol#send("cd " . expand("#:p:h") . "; " . "giac " . expand("#:p"))<CR>
nnoremap [Space]gs :b bash<CR>:call deol#send("cd " . expand("#:p:h") . "; " . "repobase; " . "git status --short")<CR>
nnoremap [Space]gt :b bash<CR>:call deol#send("cd " . expand("#:p:h") . "; " . "gitmp")<CR>
nnoremap [Space]rr :b bash<CR>:call deol#send("cd " . expand("#:p:h"))<CR>icargo run<Space>
nnoremap [Space]rc :QuickRun -args<Space>
nnoremap [Space]rp :QuickRun -args<Space>
