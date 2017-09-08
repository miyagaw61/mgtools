from enert.main import *
import datetime

argv = sys.argv
argc = len(argv)
regex_ret = re.compile(r"\s\s$")
regex_n = re.compile(r"\n")
if(argc != 2):
    print("Usage: memo [file]")
    exit()

def no_ret_lines(f):
    linedata = f.linedata()
    lines = f.lines()
    lst = []
    for i in range(lines):
        now = regex_ret.findall(linedata[i])
        if not now:
            lst.append(i)
    return lst

file_name = argv[1]
f = file(file_name)
new = file("for_md.tmp")
if new.exist():
    new.rm()

lst = no_ret_lines(f)
linedata = f.linedata()
lines = f.lines()

for i in range(lines):
    if(i in lst):
        new.add(regex_n.sub("  \n", linedata[i]))
    else:
        new.add(linedata[i])

shell("mv for_md.tmp " + file_name).call()

