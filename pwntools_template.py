from pwn import *

# ==============================
# TODO:TEMPLATE FOR EXPLOITATION
# ==============================
context(os='linux', arch='i686')
context.log_level = 'debug' # output verbose log
FILE_NAME   = './a.out'
REMOTE_LIBC = './libc.so.6-hoge'
LOCAL_LIBC  = '/lib/x86_64-linux-gnu/libc.so.6'
REMOTE_HOST = 'hoge.com'
REMOTE_PORT = 19937
LOCAL_HOST  = 'localhost'
LOCAL_PORT  = 4444
binary      = ELF(FILE_NAME)
conn        = None
dflg        = 0
if len(sys.argv) > 1 and sys.argv[1] == 'r':
    conn = remote(REMOTE_HOST, REMOTE_PORT)
    libc = ELF(REMOTE_LIBC)
elif len(sys.argv) > 1 and sys.argv[1] == "l":
    conn = process(FILE_NAME)
    libc = ELF(LOCAL_LIBC)
elif len(sys.argv) > 1 and sys.argv[1] == "d":
    dflg = 1
else:
    conn = remote(LOCAL_HOST, LOCAL_PORT)
    libc = ELF(LOCAL_LIBC)

if len(sys.argv) > 2 and sys.argv[2] == 'd':
    dflg = 1

def start():
    log.info('----- EXPLOIT START -----')
    if(dflg == 1):
        raw_input('attach...')
    recvn()

def send(x):
    conn.sendline(x)

def recv(x):
    conn.readuntil(x)

def recvn(x=4096):
    conn.read(x)

def shell():
    conn.interact()

# ==================================
# PREPARING FOR EXPLOITATION ROUTINE
# ==================================
libc_system = libc.symbols['system']
plt_read = binary.plt['read']
libc_binsh = next(libc.search('/bin/sh'))
addr_bss = binary.bss()
# ----------------------------------
def attack(x):
    send(x)
    recvn()


# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
start()
buf = "hoge"
attack(buf)
shell()
