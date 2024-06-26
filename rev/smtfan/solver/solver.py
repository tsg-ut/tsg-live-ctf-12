def s2T(s):
	assert(s[0] == '(')
	if s[1] == ')':
		return (),s[2:]
	else:
		l,s = s2T(s[1:])
		r,s = s2T(s)
		assert(s[0] == ')')
		return (l,r),s[1:]

def t2l(t):
	if len(t) == 0:
		return []
	else:
		l = t2l(t[0])
		r = t2l(t[1])
		if len(l) == 0 and len(r) == 0:
			return [[]]
		else:
			return [[1] + v for v in l] + [[0] + v for v in r]

def v2i(v):
	res = 0
	b = 1
	while True:
		d = v[:2]
		v = v[2:]
		res += b * d[0]
		b *= 2
		if d[1] == 1:
			break
	return res,v

def decode(s):
	t,s = s2T(s)
	assert(len(s) == 0)
	l = t2l(t)
	print(l)
	tl = []
	for v in l:
		x, v = v2i(v)
		y, v = v2i(v)
		assert(len(v) == 0)
		
		print(x,y)
		tl.append((y,x))
	
	tl = sorted(tl)
	flag = ""
	for i,(j,v) in enumerate(tl):
		assert(i + 1 == j)
		flag += chr(v)
	
	return flag

s = "((()((()((()((()((()((((()(()(()((()((()(()(()(((()())())()))))()))()))))())())(()((((()((()((()(()(()(((()())())()))))()))(()((()(((()())())()))(()(()(()(((()())())()))))))))(()((()(()(()(()(()(()(()(((()())())()))))))))(()((()((()(((()())())()))()))())))))())()))))(()((()((((()((()(()(()((()(()(()(((()())())()))))()))))()))())())()))()))))(()((()((((()(()(()(()(()((()(()(()(((()())())()))))()))))))())())()))(()(()(()((((()(((()())())()))())())()))))))))(()((()((()((()(((()(()(()(()(()(()(((()())())())))))))())()))()))()))(()((()(()(()(((()(()(((()())())())))())()))))(()((()((((()(()(()((()(()(()(()(()(((()())())()))))))()))))())())()))()))))))))(()((()((()((()((()(((()(()((()((()((()(()(()(((()())())()))))()))()))())))())()))()))()))(()((()((((()((()((()((()(((()())())()))()))()))()))())(((()(()(()(()(()(()(()(()(((()())())())))))))))())()))()))(()((()((((()((()(()(()((()(((()())())()))(()(()(()(((()())())()))))))))(()((()(()(()(((()())())()))))()))))(()(()(()((()(((()())())()))(()(()(()(()(()(((()())())())))))))))))())()))(()((((()((()(((()())())()))()))())())()))))))))(()((()((()((()((((()((()((()(()(()(()(()(((()())())()))))))()))()))(()((()((()(((()())())()))()))())))())()))()))(()((()(((()(()((()(()(()((()(((()())())(()(((()())())()))))()))))(()((()(()(()(((()())())()))))())))))())()))(()((((()(()(()(((()())())()))))())())()))))))(()(()(()((()(((()(()((()((()((()(((()())())()))()))()))())))())()))()))))))))))(()((()((()((()(()(()((()(((()(()(()(()((()((()(()(()(((()())())()))))(()(()(()(((()())())()))))))())))))())()))()))))(()((()((()((((()((()(()(()(((()())())()))))()))())())()))(()(((()(()((()(((()())())()))())))())()))))()))))(()(()(()((()((()((((()((()(()(()(()(()(((()())())()))))))(()(()(()((()(((()())())()))()))))))(()((()((()(()(()(()(()(((()())())()))))))()))())))())()))()))(()((()((((()(()(()((()((()(((()())())()))()))()))))())())()))()))))))))(()((()((()(()(()(()(()(((()(()(()(()(((()())())())))))())()))))))(()((()(((()(()((()(()(()(((()())())()))))())))(((()(()((()(()(()(()(()(((()())())()))))))(()(()(()((()(((()())())()))())))))))())()))(()(((((()())())())())()))))(()((()((((()(()(()(()(()(()(()(()(()(((()())())()))))))))))(()((()((()(()(()(((()())())()))))()))())))())()))()))))))(()((()(()(()(()(()((((()(()(()(()(()(((()())())()))))))())())()))))))(()((()((((()((()((()(((()())())()))()))()))())(((()(()(()(()(()(()((()(()(()(((()())())()))))())))))))())()))()))())))))))))"
s = decode(s)
print(s)

