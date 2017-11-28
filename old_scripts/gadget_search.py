# list_gadgets.py
import sys
from subprocess import Popen, PIPE

fpath = sys.argv[1]

with open(fpath, 'rb') as f:
    blob = f.read()

try:
    i = -1
    while True:
        i = blob.index('\xc3', i+1)
        for j in range(4):
            p1 = Popen(['objdump', '-M', 'intel', '-D', '-b', 'binary', '-m', 'i386', "--start-address=%d" % (i-j-1), "--stop-address=%d" % (i+1), fpath], stdout=PIPE)
            p2 = Popen(['grep', '^ '], stdin=p1.stdout, stdout=PIPE)
            stdout, stderr = p2.communicate()
            if not stdout or '(bad)' in stdout or '<internal disassembler error>' in stdout:
                continue
            lines = stdout.splitlines()
            if lines[-1].endswith('\tret    '):
                print lines[0].split('\t',1)[0] + '\t',
                print '; \t'.join(line.split('\t')[2] for line in lines[:-1])
except ValueError:
    pass
