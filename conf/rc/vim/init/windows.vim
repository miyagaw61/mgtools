"Windows
nnoremap <silent>yy :.w !win32yank.exe -i<CR><CR>
vnoremap <silent>y :w !win32yank.exe -i<CR><CR>
nnoremap <silent>dd :.w !win32yank.exe -i<CR>dd
vnoremap <silent>d x:let pos = getpos(".")<CR>GpVG:w !win32yank.exe -i<CR>VGx:call setpos(".", pos)<CR>
nnoremap <silent>p :r !win32yank.exe -o<CR>
vnoremap <silent>p :r !win32yank.exe -o<CR>

