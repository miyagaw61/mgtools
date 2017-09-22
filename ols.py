from enert import *

now, err = shell("pwd").get()
ls, err = shell("ls -F " + now).get()
ls = ls.split()
directory = []
elf = []
others = []
link = []

for i in range(len(ls)):
    if "/" == ls[i][-1]:
        directory.append(ls[i][:-1])
    elif "@" == ls[i][-1]:
        link.append(ls[i][:-1])
    elif "*" == ls[i][-1]:
        elf.append(ls[i][:-1])
    else:
        others.append(ls[i])

for var in directory:
    print(blue(var, "bold"))
for var in link:
    print(cyan(var, "bold"))
for var in elf:
    print(green(var, "bold"))
for var in others:
    print(var)
