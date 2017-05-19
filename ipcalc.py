#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, re, binascii

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

args = sys.argv
ip = ""
mask = ""
i = 0
for arg in args:
    if(arg == "ip"):
        ip = args[i+1].split(".")
    elif(arg == "mask"):
        mask = args[i+1].split(".")
    i = i + 1

ip10 = ['']*4
mask10 = ['']*4
if(ip):
    i = 0
    for var in ip:
        ip[i] = format(int(var), '08b')
        ip10[i] = str(var)
        i = i + 1
    ip = '.'.join(ip)
    ip10 = '.'.join(ip10)
    print '  IP: ' + ip + ' : ' + ip10
if(mask):
    i = 0
    for var in mask:
        mask[i] = format(int(var), '08b')
        mask10[i] = str(var)
        i = i + 1
    mask = '.'.join(mask)
    mask10 = '.'.join(mask10)
    print 'MASK: ' + mask + ' : ' + mask10

net = ['']*4
host = ['']*4
net10 = ['']*4
host10 = ['']*4
if(ip and mask):
    ip = ip.split('.')
    ip = ''.join(ip)
    mask = mask.split('.')
    mask = ''.join(mask)
    net = format(int(ip, 2) & int(mask, 2), '032b')
    net = splitn(net, 8)
    ip = splitn(ip, 8)
    ip = '.'.join(ip)
    host = format(int(mask, 2) ^ 0xffffffff, '032b')
    host = splitn(host, 8)
    for i in range(0,4):
        net10[i] = str(int(net[i], 2))
        host10[i] = str(int(host[i], 2))
    net = '.'.join(net)
    net10 = '.'.join(net10)
    host = '.'.join(host)
    host10 = '.'.join(host10)
    print ' NET: ' + net + ' : ' + net10
    print 'HOST: ' + host + ' : ' + host10
    host = host.split('.')
    host = ''.join(host)
    hosts = str(int(host, 2) - 2)
    host = splitn(host, 8)
    host = '.'.join(host)
    print 'HOSTS: ' + hosts



