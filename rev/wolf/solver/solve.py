db = "{}QWERTYUIOPASDFGHJKLZXCVBNM_"

flag = "TSGLIVE{WE_CAN_EASIRY_REVERSE_NON_ENCRYPTED_WOLVES}"

flag_enc = "TKTNT}RRUAPRHDSH{SXMREISUAH}RE}PUYPUQYDBQTLKXWCJXTY"

def enc(s):
	res = ""
	v = 0
	for c in s:
		d = 0
		if c in db:
			d = db.index(c)
		v = (v + d) % 29
		res += db[v]
	return res

print(enc(flag))

def dec(s):
	res = ""
	v = 0
	for c in s:
		d = None
		if c in db:
			d = db.index(c)
		res += db[(d+29-v)%29]
		v = d
	return res

print(dec(flag_enc))
print(dec(enc(flag)))

