" vim -b
augroup BinaryXXD
autocmd!
autocmd BufReadPre *.bin let &binary =1
" #autocmd BufReadPost * if &binary | silent %!xxd -g 1
autocmd BufReadPost * if &binary | Vinarise | endif
" #autocmd BufReadPost * set ft=xxd | endif
" #autocmd BufWritePre * if excute \"%!xxd -r\" | endif
" #autocmd BufWritePost * if &binary | silent %!xxd -g 1
" #autocmd BufWritePost * set nomod | endif
augroup END
