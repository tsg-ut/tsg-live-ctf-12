with open('problem_beforestrip.smt2','r') as fp:
	s = fp.read()

import re
s = re.split(r'("[a-z]")',s)
def f(s):
	if s[0] == '"':
		return [s]
	return re.split(r'(\W+)',s)

s = sum(map(f,s),[])
# print(s)

convd = {}
Ls = ['Tree','Bl']
ss = '''
node
left
right
leaf
cons
value
list
nil
insert
ln
rn
tostr
ls
rs
i2v
ij2v
s2tree
flag2s
s2cl
acc
x
v
t
y
s
i
'''.split('\n')[1:-1]

for i,v in enumerate(Ls):
	convd[v] = chr(ord('A')+i)

b = 0
avoid = []
# avoid = ['s','i']
for i,v in enumerate(ss):
	while True:
		tc = chr(ord('a')+i+b)
		if tc in avoid:
			b += 1
		else:
			convd[v] = tc
			break
	


def conv(v):
	if v in convd:
		return convd[v]
	
	return v
	
s = ''.join(map(conv,s))

with open('problem.smt2','w') as fp:
	fp.write(s)
