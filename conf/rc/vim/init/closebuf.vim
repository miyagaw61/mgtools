function! CloseBuf()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    :q
  else
    :bd!
  endif
endfunction

nnoremap <Leader>q :up<CR>:call CloseBuf()<CR>
