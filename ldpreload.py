import sys
import os
from enert import *
argv = sys.argv
argc = len(argv)
if argc > 1:
    libc = argv[1]
    libc = os.path.abspath(libc)
else:
    libc = "/lib/x86_64-linux-gnu/libc.so.6"
shell("export LD_PRELOAD=" + libc).call()
