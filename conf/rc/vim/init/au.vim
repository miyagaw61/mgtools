"最後のカーソル位置を記憶
"=========================
augroup vimrcEx
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

"autocmd! TermClose * call s:termexit()

autocmd BufLeave * if exists('b:term_title') && exists('b:terminal_job_pid') | execute ":file term" . b:terminal_job_pid . "/" . b:term_title
