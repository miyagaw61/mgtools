
" SCB_VSPLIT
" ==========
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
nnoremap <leader>v :call Scb_vsplit()<CR>
"# AUTO SCB_VSPLIT
"augroup scb_vsplit
"    au!
"    autocmd VimEnter * call s:scb_vsplit()
"augroup END


"GETVISUALSELECTION
"==================
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if lnum1 == 0 && lnum2 == 0 && col1 == 0 && col2 == 0
        return ''
    endif
    let lines[-1] = lines[-1][:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let ret = join(lines, "\n")
    return ret
endfunction

"terminal close
"==============
function! s:termexit() abort
    execute 'buffer #'
endfunction

"python run
"==========
"function! Python_run(arg, ...)
"    execute 'w /tmp/%.vimrun'
"    execute ':b bash'
"    execute ':cd #:h'
"    call deol#send('python run
"nnoremap [Space]rp :w /tmp/%.vimrun<CR>:b bash<CR>:cd #:h<CR>imv /tmp/vimrun.py ./vimrun.py; python vimrun.py; rm -rf vimrun.py 

command! -nargs=? MyRustRun call My_rust_run(<f-args>)
function! My_rust_run(...)
    execute "w"
    "normal !echo \"%:p:h\" > /tmp/deol_cd.tmp
    execute "b bash"
    "normal icd $(cat /tmp/deol_cd.tmp); cargo run<Space>"
    execute "call deol#send(\"cd \" . expand(\"#:p:h\") . \"; \" . \"cargo run " . join(a:000, " ") . "\")"
endfunction
