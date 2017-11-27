let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

if has('nvim')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif
