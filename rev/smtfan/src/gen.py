

def genc2i():
	res = "(-1)"
	for c in range(0x20,0x7f)[::-1]:
		res = '(ite (= "%s" s) %d %s)' % (chr(c),c,res)
	
	res = '(define-fun s2cl ((s String)) Int %s)' % res
	return res

print(genc2i())
