#!/usr/bin/env sage
# coding: utf-8
from pwn import *
context.log_level = 'debug' # output verbose log
if len(sys.argv) > 1 and sys.argv[1] == 'r':
    conn = remote("localhost", 31415)
else:
    conn = process('../src/problem.sage')

p,_ = map(int,conn.recvuntil(b'Send a point: ').split(b'\n')[0].split())
k = GF(p)
conn.send(b"1 1\n")
x,y = map(k,conn.recvuntil(b'Send a number: ').split(b'\n')[0].split())
conn.send(str(x//y)+'\n')
print(conn.recvuntil(b'}'))
