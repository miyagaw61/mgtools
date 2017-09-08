from enert.main import *
import datetime

argv = sys.argv
argc = len(argv)
regex_ret = re.compile(r"\s\s$")
regex_n = re.compile(r"\n")
regex_date = re.compile(r"\d\d\d\d-\d\d-\d\d")
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
f.edit()
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

date = datetime.date.today().isoformat()
new_file_name = regex_date.sub(date, file_name)
shell("mv for_md.tmp " + new_file_name).call()
if f.exist():
    f.rm()

