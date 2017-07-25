#!/usr/bin/python
# -*- coding: utf-8 -*-

import __main__, os, sys, struct, socket, telnetlib, subprocess, time
#from libformatstr import FormatStr
import sys, re, binascii
import pdb

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

def splitn(data, n):
    length = len(data)
    return [data[i:i+n] for i in range(0, length, n)]

def u(x):
    return struct.unpack("<I",x[:4])[0]

def u64(x):
    return struct.unpack("<I",x[:8])[0]

def p(x):
    return struct.pack("<I",x)

def p64(x):
    return struct.pack("<Q",x)

args = sys.argv
argc = len(args)

regex_ipt = re.compile(r"(.*),(.*)")

if("i" in args):
    while(True):
        sys.stdout.write(green("(calc)$ ", "bold"))
        ipt_data = input()
        ipt = regex_ipt.findall(ipt_data)
        if not(ipt):
            ipt = ipt_data
            ln = 1
            exp = ipt
        else:
            ipt = ipt[0]
            ln = len(ipt)
            if(ln == 1):
                exp = ipt[0]
            else:
                exp = ipt[0]
                fmt = ipt[1]
        if(ln == 1):
            if(exp == "q"):
                exit()
            else:
                exec("ans = "+exp+" ; print(ans)")
        else:
            if(fmt.count("x") > 0):
                exec("ans = "+exp+" ; print(hex(ans))")
            elif(fmt.count("b") > 0):
                exec("ans = "+exp+" ;print(bin(ans))")
elif("x" in args):
    fmtindex = args.index("x")
    if(fmtindex == 1):
        exp = args[2]
    else:
        exp = args[1]
    exec("ans = "+exp+" ; print(hex(ans))")
    exit()
elif("b" in args):
    fmtindex = args.index("b")
    if(fmtindex == 1):
        exp = args[2]
    else:
        exp = args[1]
    exec("ans = "+exp+" ;print(bin(ans))")
else:
    exp = args[1]
    exec("ans = "+exp+" ;print(ans)")
