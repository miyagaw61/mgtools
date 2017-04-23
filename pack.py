#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys, struct
x = int(sys.argv[1],16)
sys.stdout.write(struct.pack("<I",x))
