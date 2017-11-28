from enert import *
from argparse import ArgumentParser
import sys
import os

#if len(sys.argv) == 1:
#    Shell('$HOME/.pyenv/bin/pyenv global').call()
#    exit()
#
#if '-h' in argv:
#    print('Usage: pyv [global] [local] <option>')
#    exit()
#
#Shell(f'$HOME/.pyenv/bin/pyenv {argv[1:]}').call()
if len(sys.argv) == 1:
    Shell('pyenv local').call()
    exit()

if '-h' in argv:
    print('Usage: pyv [global] [local] <option>')
    exit()

cmd = 'pyenv ' + ' '.join(argv[1:])
Shell(cmd).call()
user = os.environ['USERNAME']
if user == 'root':
    cmd = 'PS1="${red}.---${black}(${green}\w\$(parse_branch)${black})${red}\$(parse_prompt)\n\$(cat $HOME/repos/mgtools/conf/back_quote)--> ${white}"'
else:
    cmd = 'PS1="${cyan}.---${black}(${red}\w\$(parse_branch)${black})${cyan}\$(parse_prompt)\n\'--> ${white}"'

Shell(cmd).call()
