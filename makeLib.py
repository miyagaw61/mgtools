#!/usr/bin/python
# -*- coding: utf-8 -*-

import __main__, os, sys, struct, socket, telnetlib, subprocess, time

from libformatstr import FormatStr

#import hexdump

proc = ''
s = ''
 
def local(cmd):
    __main__.proc = subprocess.Popen(cmd.strip().split(' '))
    proc.wait()

def pipelocal(cmd):
    __main__.proc = subprocess.Popen(cmd.strip().split(' '), stdin=subprocess.PIPE, stdout=subprocess.PIPE)

# socat tcp-listen:4444,reuseaddr,fork exec:./a.out
def sock(remoteip="127.0.0.1", remoteport=4444):
    __main__.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((remoteip, remoteport))
    time.sleep(0.5)

def writefile(buf_arg,file_name):
    with open(file_name, 'wb') as f:
        f.write(buf_arg)

def recv(delim='\n', out=1):
    data = ''
    while not data.endswith(delim):
        data += s.recv(1)
    if(out == 1):
        print('\nrecv: \n' + data + '\n')
    return data

def recvn(x=1024, out=1):
    data = ''
    data += s.recv(x)
    if(out == 1):
        print('\nrecv: \n' + data + '\n')
    return data

def send(x, sleep=0.3, out=1):
    s.sendall(x + '\n')
    if(out == 1):
        print('\nsend: \n' + x + '\n')
    time.sleep(sleep)

def u(x):
    return struct.unpack("<I",x[:4])[0]

def u64(x):
    return struct.unpack("<I",x[:8])[0]

def p(x):
    return struct.pack("<I",x)

def p64(x):
    return struct.pack("<Q",x)

def shell():
    if(s != ''):
        print('---- interactive mode ----')
        t= telnetlib.Telnet()
        t.sock = s
        t.interact()
    elif(p != ''):
        print('---- interactive mode ----')
        proc.wait()

#katagaitai_command_start
#def xxd(a):
#    hexdump.hexdump(a)
#
#def dbg(ss):
#    print "[+] %s: 0x%x"%(ss, eval(ss))
#
#def countdown(n):
#    for i in xrange(n,0,-1):
#        print str(i) + "..",
#        sys.stdout.flush()
#        time.sleep(1)
#    print
#katagaitai_command_end

def xxd(a):
    a = str(a)
    hexdump.hexdump(a)

def read(delim="\n"):
    data = ''
    while not data.endswith(delim):
        data += proc.stdout.readlne(1)
    print('\nread: \n' + data + '\n')
    return data

def readn(num):
    data = ''
    while(num>0):
        data += proc.stdout.read(1)
        num = num-1
    print('\nread: \n' + data + '\n')
    return data
 
def fsa1(recent_len, index_start, after_data):
    data = '%' + \
            str( ((after_data-int(hex(recent_len)[:4],16)-1)%0x100)+1 ) + \
            'c%' + str(index_start) + '$hhn'
    return data

def fsa4(recent_len, index_start, after_addr):
    a = map(ord,p(after_addr))
    b = map(ord,p(after_addr))
    a[3] = ((a[3]-a[2]-1) % 0x100) + 1
    a[2] = ((a[2]-a[1]-1) % 0x100) + 1
    a[1] = ((a[1]-a[0]-1) % 0x100) + 1
    a[0] = ((a[0]-int(hex(recent_len)[:4],16)-1) % 0x100) + 1
    data = ''
    data += '%{0}c'.format(str(a[0])) + \
            '%' + str(index_start+0) + '$hhn'
    data += '%{0}c'.format(str(a[1])) + \
            '%' + str(index_start+1) + '$hhn'
    data += '%{0}c'.format(str(a[2])) + \
            '%' + str(index_start+2) + '$hhn'
    data += '%{0}c'.format(str(a[3])) + \
            '%' + str(index_start+3) + '$hhn'
    return data

sc_execve32 = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_execve64 = "\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xeb\x08\x53\x48\x89\xe7\x50\x57\x48\x89\xe6\xb0\x3b\x0f\x05"

#-----------START EXPLOIT CODE-----------#

lst = open(sys.argv[1], 'r').read().split('\n')
line = len(lst) - 1
x = int(sys.argv[2])
out = sys.argv[3]

print('[+] lst: %s' % lst)
print('[+] x: %d' % x)
print('[+] line: %d' % line)

i = 0
j = 0
n = 0
while(n < x):
    while(i < line):
        base = lst[i]
        while(j < line):
            lst.append(base + lst[j])
            j = j + 1
        i = i + 1
        j = 0
    n = n + 1
    line = len(lst)
    i = i + 1

lst = '\n'.join(lst)
writefile(lst, out)
